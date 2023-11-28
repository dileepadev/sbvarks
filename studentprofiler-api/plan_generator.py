# Define the activities in dictionaries
activities = {
    'V': {
        1: [
            "Counting with Visual Aids: Use colorful counters, beads, or small objects to help the child understand basic counting and addition/subtraction.",
            "Math Picture Books: Explore picture books that incorporate visuals to teach math concepts, such as 'Ten Black Dots' by Donald Crews.",
            "Shape Recognition: Create a game where the student identifies and matches shapes using visual cards or objects.",
            "Math Art Coloring: Provide math-themed coloring sheets that require the child to color by number or solve simple visual math puzzles."
        ],
        2: [
            "Geometric Pattern Design: Encourage the child to create their geometric patterns using various shapes and colors.",
            "Math Board Games: Play visually engaging math board games like 'Math Bingo' or 'Fraction War.'",
            "Graphing with Pictures: Teach basic graphing by having the student create bar graphs or pie charts using visual representations.",
            "Visual Problem Solving: Use logic puzzles and Sudoku puzzles with colorful visual elements to develop problem-solving skills."
        ],
        3: [
            "Fraction Pie Charts: Use pie charts to teach fractions visually, letting the student shade in fractions of a circle.",
            "Math Videos with Visuals: Explore online math videos that provide visual explanations of mathematical concepts.",
            "Geometry with Tangrams: Solve geometric puzzles and explore spatial relationships using tangram sets.",
            "Math Art Projects: Engage in art projects that involve creating geometric patterns or symmetrical designs."
        ],
        4: [
            "Advanced Visual Puzzles: Challenge the student with more complex visual puzzles like Sudoku, Kakuro, or visual logic puzzles.",
            "Graphing and Data Visualization: Teach more advanced graphing and data visualization techniques, including line graphs and scatter plots.",
            "Math Exploration through Infographics: Explore math-related infographics to help the child understand real-world applications of math.",
            "Create Visual Math Guides: Have the student create their visual math guides or cheat sheets to summarize key concepts."
        ]
    },
    'A': {
        1: [
            "Math Songs and Rhymes: Introduce basic math concepts through songs and rhymes focused on counting, addition, and subtraction.",
            "Math Storytelling: Create simple math stories or scenarios that the child can listen to and solve problems within.",
            "Counting with Rhyming: Use rhymes to help the child learn to count by twos, threes, etc.",
            "Listening to Math Podcasts: Explore age-appropriate math podcasts that explain math concepts through storytelling and examples."
        ],
        2: [
            "Math Word Problems with Narration: Provide auditory word problems and have the student narrate their thought process as they solve them.",
            "Auditory Memory Games: Play memory games that involve recalling number sequences or mathematical facts through sound.",
            "Auditory Math Discussions: Engage in math discussions with the student, allowing them to talk through their problem-solving steps.",
            "Auditory Math Stories: Explore math-related stories that provide step-by-step auditory explanations of concepts."
        ],
        3: [
            "Math Podcast Exploration: Encourage the child to explore a variety of math podcasts that dive deeper into mathematical concepts.",
            "Auditory Math Puzzles: Provide audio-based math puzzles and challenge the student to solve them using their auditory skills.",
            "Math Audiobooks: Listen to math-themed audiobooks that explain advanced concepts in an engaging way.",
            "Auditory Math Quizzes: Create auditory quizzes or games where the child listens to math problems and answers them verbally."
        ],
        4: [
            "Math Explainers: Encourage the child to create their audio explanations of math concepts to reinforce their understanding.",
            "Debates and Discussions: Organize math debates or discussions where the student can argue and explain their mathematical reasoning.",
            "Auditory Math Projects: Have the student work on long-term math projects that require them to present their findings and solutions orally.",
            "Math Podcast Creation: Challenge the child to create their math-related podcast episodes, summarizing and explaining math topics."
        ]
    },
    'R': {
        1: [
            "Math Storybooks: Read math-themed storybooks together, focusing on the narrative and discussing the math within the story.",
            "Math Worksheets: Start with simple math worksheets that involve reading instructions and writing answers.",
            "Math Flashcards: Create flashcards with math problems and have the child write the solutions.",
            "Number Tracing: Practice writing numbers and basic math symbols like + and -."
        ],
        2: [
            "Math Word Problems: Introduce word problems that require reading comprehension and written solutions.",
            "Math Journals: Encourage the child to keep a math journal to write down their thoughts, solutions, and reflections on math concepts.",
            "Math Storytelling: Have the student write their math stories or word problems for others to solve.",
            "Math Blogging: If they're interested, help them start a simple math blog where they write about their math explorations."
        ],
        3: [
            "Math Books: Explore age-appropriate math books and encourage the child to write summaries or reflections about what they've learned.",
            "Math Reports: Assign small research projects where the child writes reports about historical mathematicians, math concepts, or real-world math applications.",
            "Math Diagrams and Labels: Teach the child to create diagrams and label parts to explain math concepts visually.",
            "Math Storytelling Competitions: Organize math storytelling competitions where the child writes and presents their math stories to others."
        ],
        4: [
            "Math Essay Writing: Have the student write longer essays or reports on advanced math topics or mathematical discoveries.",
            "Math Creative Writing: Encourage creative writing related to math, such as math-inspired short stories or poems.",
            "Math Publishing: Help the child compile their math writings into a booklet or digital portfolio to share with others.",
            "Math Journal Publication: Guide the child in submitting their math journal entries for publication in school newsletters or online platforms."
        ]
    },
    'K': {
        1: [
            "Math Manipulative Games: Play hands-on math games using physical objects like dice, counting beans, or building blocks.",
            "Math Action Songs: Create songs or chants with physical movements that teach counting, addition, or subtraction.",
            "Math Scavenger Hunt: Set up a math-themed scavenger hunt where the child has to physically find and solve math problems.",
            "Outdoor Math Exploration: Take math learning outdoors and use natural objects like sticks and stones for counting and basic operations."
        ],
        2: [
            "Math Board Games: Play math board games that involve physical movement, such as 'Math Twister.'",
            "Math Relay Races: Organize math relay races where the child has to solve math problems at different stations.",
            "Math Building Projects: Engage in building projects that incorporate math concepts, like creating structures with specific dimensions.",
            "Math Cooking: Involve the child in cooking or baking activities where they can measure ingredients and apply math concepts."
        ],
        3: [
            "Math Sports: Incorporate math into sports activities, such as measuring distances or calculating scores.",
            "Math DIY Projects: Encourage the child to take on DIY math projects like making geometric shapes from craft materials.",
            "Math Gardening: Integrate math into gardening activities, such as measuring plant growth or spacing.",
            "Math Puzzle Assembly: Use physical jigsaw puzzles with math themes to teach problem-solving and spatial skills."
        ],
        4: [
            "Math Sculpting: Allow the child to create 3D math models or sculptures related to mathematical concepts.",
            "Math Movement Games: Play math-themed movement games where the child has to physically represent math operations or concepts.",
            "Math Sports Tournaments: Organize math sports tournaments where the child competes in math-related physical challenges.",
            "Math Building Challenges: Challenge the child to build complex structures or designs using math principles they've learned."
        ]
    }
}


def get_plan(learning_style, set_number):
    try:
        activities_list = activities[learning_style][set_number]
        return activities_list
    except KeyError:
        return []
