import cv2
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D, Dense, Dropout, Flatten
from keras.optimizers import Adam
from keras.preprocessing.image import ImageDataGenerator

# Initialize image data generator with rescaling
train_data_gen = ImageDataGenerator(rescale=1. / 255)
validation_data_gen = ImageDataGenerator(rescale=1. / 255)

# Preprocess all test images
train_generator = train_data_gen.flow_from_directory(
    'data/train',
    target_size=(48, 48),
    batch_size=64,
    color_mode="grayscale",
    class_mode='categorical')

# Preprocess all train images
validation_generator = validation_data_gen.flow_from_directory(
    'data/test',
    target_size=(48, 48),
    batch_size=64,
    color_mode="grayscale",
    class_mode='categorical')

# create model structure
fer_model = Sequential()

fer_model.add(Conv2D(32, kernel_size=(3, 3), activation='relu', input_shape=(48, 48, 1)))
fer_model.add(Conv2D(64, kernel_size=(3, 3), activation='relu'))
fer_model.add(MaxPooling2D(pool_size=(2, 2)))
fer_model.add(Dropout(0.25))

fer_model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
fer_model.add(MaxPooling2D(pool_size=(2, 2)))
fer_model.add(Conv2D(128, kernel_size=(3, 3), activation='relu'))
fer_model.add(MaxPooling2D(pool_size=(2, 2)))
fer_model.add(Dropout(0.25))

fer_model.add(Flatten())
fer_model.add(Dense(1024, activation='relu'))
fer_model.add(Dropout(0.5))
fer_model.add(Dense(7, activation='softmax'))

cv2.ocl.setUseOpenCL(False)

fer_model.compile(loss='categorical_crossentropy', optimizer=Adam(learning_rate=0.0001, epsilon=1e-6),
                  metrics=['accuracy'])

# Train the neural network/model
fer_model_info = fer_model.fit(
    train_generator,
    steps_per_epoch=28709 // 64,
    epochs=50,
    validation_data=validation_generator,
    validation_steps=7178 // 64)

# save model structure in jason file
model_json = fer_model.to_json()
with open("fer_model.json", "w") as json_file:
    json_file.write(model_json)

# save trained model weight in .h5 file
fer_model.save_weights('fer_model.h5')
