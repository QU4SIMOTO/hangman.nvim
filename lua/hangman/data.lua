local M = {}

--- @type string[] List of words to guess
M.words = {
  "ABRUPTLY",
  "ABSURD",
  "ABYSS",
  "AFFIX",
  "ASKEW",
  "AVENUE",
  "AWKWARD",
  "AXIOM",
  "AZURE",
  "BAGPIPES",
  "BANDWAGON",
  "BANJO",
  "BAYOU",
  "BEEKEEPER",
  "BIKINI",
  "BLITZ",
  "BLIZZARD",
  "BOGGLE",
  "BOOKWORM",
  "BOXCAR",
  "BOXFUL",
  "BUCKAROO",
  "BUFFALO",
  "BUFFOON",
  "BUXOM",
  "BUZZARD",
  "BUZZING",
  "BUZZWORDS",
  "CALIPH",
  "COBWEB",
  "COCKINESS",
  "CROQUET",
  "CRYPT",
  "CURACAO",
  "CYCLE",
  "DAIQUIRI",
  "DIRNDL",
  "DISAVOW",
  "DIZZYING",
  "DUPLEX",
  "DWARVES",
  "EMBEZZLE",
  "EQUIP",
  "ESPIONAGE",
  "EUOUAE",
  "EXODUS",
  "FAKING",
  "FISHHOOK",
  "FIXABLE",
  "FJORD",
  "FLAPJACK",
  "FLOPPING",
  "FLUFFINESS",
  "FLYBY",
  "FOXGLOVE",
  "FRAZZLED",
  "FRIZZLED",
  "FUCHSIA",
  "FUNNY",
  "GABBY",
  "GALAXY",
  "GALVANIZE",
  "GAZEBO",
  "GIAOUR",
  "GIZMO",
  "GLOWWORM",
  "GLYPH",
  "GNARLY",
  "GNOSTIC",
  "GOSSIP",
  "GROGGINESS",
  "HAIKU",
  "HAPHAZARD",
  "HYPHEN",
  "IATROGENIC",
  "ICEBOX",
  "INJURY",
  "IVORY",
  "IVY",
  "JACKPOT",
  "JAUNDICE",
  "JAWBREAKER",
  "JAYWALK",
  "JAZZIEST",
  "JAZZY",
  "JELLY",
  "JIGSAW",
  "JINX",
  "JIUJITSU",
  "JOCKEY",
  "JOGGING",
  "JOKING",
  "JOVIAL",
  "JOYFUL",
  "JUICY",
  "JUKEBOX",
  "JUMBO",
  "KAYAK",
  "KAZOO",
  "KEYHOLE",
  "KHAKI",
  "KILOBYTE",
  "KIOSK",
  "KITSCH",
  "KIWIFRUIT",
  "KLUTZ",
  "KNAPSACK",
  "LARYNX",
  "LENGTHS",
  "LUCKY",
  "LUXURY",
  "LYMPH",
  "MARQUIS",
  "MATRIX",
  "MEGAHERTZ",
  "MICROWAVE",
  "MNEMONIC",
  "MYSTIFY",
  "NAPHTHA",
  "NIGHTCLUB",
  "NOWADAYS",
  "NUMBSKULL",
  "NYMPH",
  "ONYX",
  "OVARY",
  "OXIDIZE",
  "OXYGEN",
  "PAJAMA",
  "PEEKABOO",
  "PHLEGM",
  "PIXEL",
  "PIZAZZ",
  "PNEUMONIA",
  "POLKA",
  "PSHAW",
  "PSYCHE",
  "PUPPY",
  "PUZZLING",
  "QUARTZ",
  "QUEUE",
  "QUIPS",
  "QUIXOTIC",
  "QUIZ",
  "QUIZZES",
  "QUORUM",
  "RAZZMATAZZ",
  "RHUBARB",
  "RHYTHM",
  "RICKSHAW",
  "SCHNAPPS",
  "SCRATCH",
  "SHIV",
  "SNAZZY",
  "SPHINX",
  "SPRITZ",
  "SQUAWK",
  "STAFF",
  "STRENGTH",
  "STRENGTHS",
  "STRETCH",
  "STRONGHOLD",
  "STYMIED",
  "SUBWAY",
  "SWIVEL",
  "SYNDROME",
  "THRIFTLESS",
  "THUMBSCREW",
  "TOPAZ",
  "TRANSCRIPT",
  "TRANSGRESS",
  "TRANSPLANT",
  "TRIPHTHONG",
  "TWELFTH",
  "TWELFTHS",
  "UNKNOWN",
  "UNWORTHY",
  "UNZIP",
  "UPTOWN",
  "VAPORIZE",
  "VIXEN",
  "VODKA",
  "VOODOO",
  "VORTEX",
  "VOYEURISM",
  "WALKWAY",
  "WALTZ",
  "WAVE",
  "WAVY",
  "WAXY",
  "WELLSPRING",
  "WHEEZY",
  "WHISKEY",
  "WHIZZING",
  "WHOMEVER",
  "WIMPY",
  "WITCHCRAFT",
  "WIZARD",
  "WOOZY",
  "WRISTWATCH",
  "WYVERN",
  "XYLOPHONE",
  "YACHTSMAN",
  "YIPPEE",
  "YOKED",
  "YOUTHFUL",
  "YUMMY",
  "ZEPHYR",
  "ZIGZAG",
  "ZIGZAGGING",
  "ZILCH",
  "ZIPPER",
  "ZODIAC",
  "ZOMBIE",
}

---Get a random word from the words list
---@return string word
function M.get_random_word()
  math.randomseed(os.time())
  return M.words[math.random(1, #M.words)]
end

return M
