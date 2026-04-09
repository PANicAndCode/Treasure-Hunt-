const CLUES = {
  "1": {
    "title": "Your first checkpoint waits where visitors usually arrive.",
    "location": "Front entrance",
    "hint": "Start near the main way in.",
    "zone": { "x": 18, "y": 18 }
  },
  "2": {
    "title": "Search the place where people gather for quick updates.",
    "location": "Common table",
    "hint": "Think about the busiest surface in the space.",
    "zone": { "x": 33, "y": 26 }
  },
  "3": {
    "title": "The next clue is hiding near something that opens and closes all day.",
    "location": "Supply cabinet",
    "hint": "Look for a door with shared tools inside.",
    "zone": { "x": 48, "y": 20 }
  },
  "4": {
    "title": "Check the spot that lights up the room when the sun is gone.",
    "location": "Floor lamp",
    "hint": "Find a warm glow.",
    "zone": { "x": 63, "y": 18 }
  },
  "5": {
    "title": "Head to the place where teams pause between missions.",
    "location": "Lounge corner",
    "hint": "Look for a good place to sit and regroup.",
    "zone": { "x": 77, "y": 26 }
  },
  "6": {
    "title": "Your next checkpoint is near something cold and useful.",
    "location": "Kitchen fridge",
    "hint": "Search where drinks and snacks stay chilled.",
    "zone": { "x": 72, "y": 44 }
  },
  "7": {
    "title": "Find the clue hiding close to the clean-up station.",
    "location": "Sink area",
    "hint": "Water, soap, and hand towels.",
    "zone": { "x": 58, "y": 52 }
  },
  "8": {
    "title": "The next clue sits near a place built for storing the extras.",
    "location": "Storage shelf",
    "hint": "Look where backup supplies live.",
    "zone": { "x": 41, "y": 58 }
  },
  "9": {
    "title": "Search the edge of the room where people usually line up gear.",
    "location": "Wall hooks",
    "hint": "Think bags, coats, or keys.",
    "zone": { "x": 26, "y": 68 }
  },
  "10": {
    "title": "The final regular checkpoint is waiting near a place with fresh air.",
    "location": "Patio door",
    "hint": "Look where inside meets outside.",
    "zone": { "x": 82, "y": 66 }
  },
  "11": {
    "title": "Final clue: look where winners would leave proof they made it.",
    "location": "Prize table",
    "hint": "You can't use a hint for this clue.",
    "noHint": true,
    "zone": { "x": 50, "y": 80 }
  }
};

const TEAMS = {
  "Team1": {
    "label": "Team 1",
    "sequence": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
  },
  "Team2": {
    "label": "Team 2",
    "sequence": [5, 1, 8, 2, 9, 3, 6, 4, 10, 7, 11]
  },
  "Team3": {
    "label": "Team 3",
    "sequence": [7, 4, 2, 10, 1, 9, 5, 8, 3, 6, 11]
  },
  "Team4": {
    "label": "Team 4",
    "sequence": [3, 6, 1, 9, 4, 7, 10, 2, 8, 5, 11]
  },
  "Team5": {
    "label": "Team 5",
    "sequence": [8, 10, 5, 7, 2, 6, 4, 1, 9, 3, 11]
  }
};

const TOKENS = {
  "Team1": [
    "OGZMXS7VJB",
    "60GIIUEG45",
    "KDEAYOPPXE",
    "07R78W8USC",
    "DA17HH1YCL",
    "HKD5RKKNM3",
    "C10PEXRT5Z",
    "G942RD8UA7",
    "UO6AZKDN71",
    "YOI2ZQGYGL",
    "TK0KAKONVN"
  ],
  "Team2": [
    "DA17HH1YCL",
    "OGZMXS7VJB",
    "G942RD8UA7",
    "60GIIUEG45",
    "UO6AZKDN71",
    "KDEAYOPPXE",
    "HKD5RKKNM3",
    "07R78W8USC",
    "YOI2ZQGYGL",
    "C10PEXRT5Z",
    "TK0KAKONVN"
  ],
  "Team3": [
    "C10PEXRT5Z",
    "07R78W8USC",
    "60GIIUEG45",
    "YOI2ZQGYGL",
    "OGZMXS7VJB",
    "UO6AZKDN71",
    "DA17HH1YCL",
    "G942RD8UA7",
    "KDEAYOPPXE",
    "HKD5RKKNM3",
    "TK0KAKONVN"
  ],
  "Team4": [
    "KDEAYOPPXE",
    "HKD5RKKNM3",
    "OGZMXS7VJB",
    "UO6AZKDN71",
    "07R78W8USC",
    "C10PEXRT5Z",
    "YOI2ZQGYGL",
    "60GIIUEG45",
    "G942RD8UA7",
    "DA17HH1YCL",
    "TK0KAKONVN"
  ],
  "Team5": [
    "G942RD8UA7",
    "YOI2ZQGYGL",
    "DA17HH1YCL",
    "C10PEXRT5Z",
    "60GIIUEG45",
    "HKD5RKKNM3",
    "07R78W8USC",
    "OGZMXS7VJB",
    "UO6AZKDN71",
    "KDEAYOPPXE",
    "TK0KAKONVN"
  ]
};
