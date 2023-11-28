import os
import pandas as pd
import matplotlib.pyplot as plt

# Define a dictionary to map the emotion values to their names
emotion_dict = {0: "Angry", 1: "Disgusted", 2: "Fearful", 3: "Happy", 4: "Neutral", 5: "Sad", 6: "Surprised"}

# Read the CSV files
emotion_stats = pd.read_csv('models/ferd/csv/emotion_statistics.csv')
emotion_count = pd.read_csv('models/ferd/csv/emotion_count.csv')

videoName = "a"

# Create a 'charts' folder if it doesn't exist
if not os.path.exists('models/ferd/charts'):
    os.makedirs('models/ferd/charts')

# Display a bar chart for emotion counts
plt.figure(figsize=(10, 6))
plt.bar(emotion_count['Emotion'], emotion_count['Count'])
plt.title('Emotion Count')
plt.xlabel('Emotion')
plt.ylabel('Count')
plt.xticks(rotation=45)
plt.tight_layout()

# Save the bar chart
plt.savefig('models/ferd/charts/' + videoName + '_emotion_count.png')

# Display a pie chart for emotion counts
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))
ax1.pie(emotion_count['Count'], labels=emotion_count['Emotion'], autopct='%1.1f%%')
table = ax2.table(cellText=emotion_count.values,
                  colLabels=emotion_count.columns,
                  cellLoc='center', loc='center')
table.auto_set_font_size(False)
table.set_fontsize(10)
table.scale(1.2, 1.2)
ax2.axis('off')
title = fig.suptitle('Emotion Distribution', fontsize=16)
fig.subplots_adjust(top=0.85)
plt.tight_layout()

# Save the pie chart
plt.savefig('models/ferd/charts/' + videoName + '_emotion_distribution.png')

# Display a dotted chart for the top 3 emotion values over time
plt.figure(figsize=(10, 6))
top_emotions = emotion_count.nlargest(3, 'Count')['Emotion']  # Get top 3 emotions by count
print("Top 3 Emotions:")
print(top_emotions)
for emotion in top_emotions:
    emotion_data = emotion_stats[emotion_stats['Emotion'] == emotion]
    plt.plot(emotion_data['Timestamp'], emotion_data['Value'], '--', marker='o', label=emotion)

plt.title('Emotion Values Over Time (Top 3 Emotions)')
plt.xlabel('Timestamp')
plt.ylabel('Emotion Value')
plt.legend()
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig('models/ferd/charts/' + videoName + '_emotion_values.png')

plt.close()
# Show the plots
# plt.show()

print("Done!")
