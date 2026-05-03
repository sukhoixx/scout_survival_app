# Scout Survival App

An offline iOS wilderness survival guide for scouts featuring hierarchical topic browsing, first aid reference, and symptom-based illness assessment.

## Features

| Tab | Description |
|-----|-------------|
| **Browse** | Drill down through survival topics: Fire, Shelter, Water, Navigation, Food, Signaling, Tools & Knots |
| **Search** | Full-text search across all articles and injury/illness entries |
| **First Aid** | Filterable reference of injuries and illnesses with step-by-step treatment guides |
| **Assess** | Select symptoms to get probability-ranked list of possible conditions with treatments |

## Project Structure

```
scout_survival_app/
├── App/
│   ├── ScoutSurvivalApp.swift     # App entry point
│   └── ContentView.swift          # Tab bar navigation
├── Models/
│   ├── Topic.swift                # Topic + Article models
│   ├── Injury.swift               # Injury + Treatment models
│   ├── Assessment.swift           # Symptom + probability models
│   └── SurvivalDataStore.swift    # ObservableObject data layer + search/assess logic
├── Views/
│   ├── BrowseView.swift           # Topic grid home screen
│   ├── TopicDetailView.swift      # Drill-down subtopics and articles
│   ├── ArticleDetailView.swift    # Formatted article reader with font size control
│   ├── SearchView.swift           # Full-text search with topic/injury filter
│   ├── FirstAidView.swift         # Filterable injury list by category
│   ├── InjuryDetailView.swift     # Full injury detail with treatment steps
│   └── AssessmentView.swift       # Symptom picker + probability results
├── Data/
│   ├── survival_topics.json       # All survival topics, subtopics, and articles
│   └── injuries.json              # All injuries/illnesses with treatments
└── Resources/
    └── Info.plist
```

## Setup Options

### Option A: XcodeGen (Recommended)

1. Install XcodeGen: `brew install xcodegen`
2. From the `scout_survival_app/` root directory:
   ```bash
   xcodegen generate
   ```
3. Open `scout_survival_app.xcodeproj` in Xcode
4. Select your development team in Signing & Capabilities
5. Build and run on simulator or device (iOS 17+)

### Option B: Manual Xcode Project

1. Open Xcode → New Project → iOS → App
2. Set Product Name: `scout_survival_app`
3. Interface: SwiftUI, Language: Swift, minimum deployment: iOS 17
4. Delete the generated ContentView.swift
5. Drag all files from this project's `scout_survival_app/` folder into the Xcode project
6. Ensure `survival_topics.json` and `injuries.json` are added as bundle resources
7. Build and run

## Data Extension

### Adding Topics

Edit `Data/survival_topics.json`. Topics support unlimited nesting via the `subtopics` array. Articles support markdown-style formatting with `#`, `##`, `- ` (bullets), and `**bold**`.

### Adding Injuries

Edit `Data/injuries.json`. Each injury entry includes:
- `symptoms` — list of symptom strings used by the Assessment engine
- `immediateActions` — critical first steps shown prominently
- `treatments` — numbered steps with required materials
- `warningSigns` — escalation indicators
- `whenToEvacuate` — evacuation criteria
- `preventionTips` — educational content

## Assessment Algorithm

The symptom assessment uses Jaccard similarity: matching symptoms / union of patient symptoms and condition symptoms. Results are ranked by probability score and tagged as High (≥60%), Medium (≥30%), or Low (<30%) confidence.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- No external dependencies — fully offline

## Disclaimer

This app is an educational reference tool for training purposes. It is **not** a substitute for proper first aid training, medical advice, or professional emergency services. Always seek professional medical help when available.
