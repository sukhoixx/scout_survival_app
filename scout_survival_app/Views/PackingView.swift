import SwiftUI

// MARK: - Models

struct PackingEnvironment: Identifiable {
    let id: String
    let name: String
    let icon: String
    let color: Color
    let tagline: String
    let sections: [PackingSection]
    let medicines: [MedicineItem]
}

struct PackingSection: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let items: [PackingItem]
}

struct PackingItem: Identifiable {
    let id = UUID()
    let name: String
    let essential: Bool
    let note: String?

    init(_ name: String, essential: Bool = false, note: String? = nil) {
        self.name = name
        self.essential = essential
        self.note = note
    }
}

struct MedicineItem: Identifiable {
    let id = UUID()
    let situation: String
    let recommended: MedicineOption
    let avoid: MedicineOption
}

struct MedicineOption {
    let name: String
    let dosage: String
    let reason: String
}

// MARK: - Packing Data

let packingEnvironments: [PackingEnvironment] = [
    PackingEnvironment(
        id: "snowy-mountain",
        name: "Snowy Mountain",
        icon: "mountain.2.fill",
        color: .cyan,
        tagline: "Alpine & winter terrain",
        sections: [
            PackingSection(title: "Clothing", icon: "tshirt.fill", items: [
                PackingItem("Moisture-wicking base layer", essential: true),
                PackingItem("Insulating mid layer (fleece or down)", essential: true),
                PackingItem("Waterproof shell jacket", essential: true),
                PackingItem("Waterproof shell pants", essential: true),
                PackingItem("Insulated boots (rated -20°F or below)", essential: true),
                PackingItem("Wool socks × 3 pairs", essential: true),
                PackingItem("Balaclava", essential: true),
                PackingItem("Insulated gloves + liner gloves", essential: true),
                PackingItem("Snow goggles", essential: true),
                PackingItem("Gaiters"),
                PackingItem("Warm hat"),
            ]),
            PackingSection(title: "Shelter", icon: "tent.fill", items: [
                PackingItem("4-season tent or snow shelter kit", essential: true),
                PackingItem("Sleeping bag rated -20°F or below", essential: true),
                PackingItem("Insulated sleeping pad (R-value 4+)", essential: true, note: "Ground insulation is critical in snow"),
                PackingItem("Emergency bivvy", essential: true),
                PackingItem("Extra tent stakes for snow"),
            ]),
            PackingSection(title: "Water & Food", icon: "drop.fill", items: [
                PackingItem("Insulated water bottles (prevent freezing)", essential: true),
                PackingItem("Stove + fuel to melt snow", essential: true),
                PackingItem("Water filter (when running water is available)"),
                PackingItem("High-calorie dense food", essential: true, note: "Cold increases caloric burn by 25–50%"),
                PackingItem("Extra 1–2 days emergency rations", essential: true),
                PackingItem("Hot drink supplies (tea, cocoa)"),
            ]),
            PackingSection(title: "Safety", icon: "cross.case.fill", items: [
                PackingItem("Avalanche beacon", essential: true, note: "Required in avalanche terrain"),
                PackingItem("Avalanche probe", essential: true),
                PackingItem("Avalanche shovel", essential: true),
                PackingItem("Headlamp + extra batteries", essential: true),
                PackingItem("Fire-starting kit", essential: true),
                PackingItem("Emergency whistle", essential: true),
                PackingItem("Sunscreen SPF 50+ & lip balm", note: "Snow reflects and intensifies UV"),
                PackingItem("Hand warmers × 6+ pairs"),
                PackingItem("First aid kit"),
            ]),
            PackingSection(title: "Navigation", icon: "safari.fill", items: [
                PackingItem("Topographic map (waterproof)", essential: true),
                PackingItem("Compass", essential: true),
                PackingItem("GPS or satellite communicator", essential: true),
                PackingItem("Altimeter watch"),
            ]),
        ],
        medicines: [
            MedicineItem(
                situation: "Altitude Sickness (AMS)",
                recommended: MedicineOption(
                    name: "Acetazolamide (Diamox)",
                    dosage: "125–250 mg twice daily, starting 24 hrs before ascent",
                    reason: "Stimulates faster breathing and accelerates acclimatization. Proven to prevent and treat AMS, HACE, and HAPE onset."
                ),
                avoid: MedicineOption(
                    name: "Ibuprofen alone",
                    dosage: "400 mg every 6–8 hrs",
                    reason: "Relieves headache pain but does NOT prevent or treat the underlying pressure buildup. AMS can escalate to life-threatening HACE or HAPE while symptoms feel managed."
                )
            ),
            MedicineItem(
                situation: "Pain & Inflammation (cold injuries, muscle strain)",
                recommended: MedicineOption(
                    name: "Ibuprofen (Advil / Motrin)",
                    dosage: "400 mg every 6–8 hrs with food",
                    reason: "Reduces both pain and inflammation. Preferred for cold-injury soreness and musculoskeletal pain in cold environments."
                ),
                avoid: MedicineOption(
                    name: "Aspirin",
                    dosage: "325–650 mg every 4–6 hrs",
                    reason: "Thins blood, increasing bleeding risk — dangerous in remote cold environments where hemorrhage is hard to manage. Also raises frostbite complication risk."
                )
            ),
            MedicineItem(
                situation: "Severe Allergic Reaction / Anaphylaxis",
                recommended: MedicineOption(
                    name: "Epinephrine Auto-Injector (EpiPen)",
                    dosage: "0.3 mg IM into outer thigh; repeat after 5–15 min if no improvement",
                    reason: "The only first-line treatment for anaphylaxis. Reverses airway constriction and dangerous blood pressure drop within minutes."
                ),
                avoid: MedicineOption(
                    name: "Diphenhydramine (Benadryl) alone",
                    dosage: "25–50 mg oral",
                    reason: "Too slow to stop anaphylaxis — takes 20–30 min to absorb and does not reverse airway swelling. Using it instead of epinephrine is a fatal mistake. Use only as a follow-up after epinephrine."
                )
            ),
        ]
    ),
    PackingEnvironment(
        id: "grassy-field",
        name: "Grassy Field",
        icon: "leaf.fill",
        color: .green,
        tagline: "Open meadows & rolling terrain",
        sections: [
            PackingSection(title: "Clothing", icon: "tshirt.fill", items: [
                PackingItem("Moisture-wicking shirts × 2", essential: true),
                PackingItem("Wide-brim sun hat", essential: true),
                PackingItem("Long pants (tick protection)", essential: true),
                PackingItem("Light rain jacket", essential: true),
                PackingItem("Permethrin-treated clothing", note: "Pre-treat at home before the trip"),
                PackingItem("Warm layer for evenings"),
                PackingItem("Sturdy trail shoes or boots"),
            ]),
            PackingSection(title: "Shelter", icon: "tent.fill", items: [
                PackingItem("Lightweight 3-season tent", essential: true),
                PackingItem("Sleeping bag (40°F rating)", essential: true),
                PackingItem("Sleeping pad"),
                PackingItem("Tarp for midday shade"),
                PackingItem("Tent footprint or ground cloth"),
            ]),
            PackingSection(title: "Water & Food", icon: "drop.fill", items: [
                PackingItem("2–3L water capacity", essential: true),
                PackingItem("Water filter", essential: true),
                PackingItem("Electrolyte tablets"),
                PackingItem("Chemical purification backup"),
                PackingItem("Lightweight trail meals", essential: true),
                PackingItem("High-energy snacks", essential: true),
                PackingItem("Bear hang rope or canister", note: "Essential even in open terrain"),
                PackingItem("Stove + fuel"),
            ]),
            PackingSection(title: "Safety", icon: "cross.case.fill", items: [
                PackingItem("Insect repellent (DEET 30%+)", essential: true),
                PackingItem("Tick removal tool", essential: true),
                PackingItem("Sunscreen SPF 50+", essential: true),
                PackingItem("Headlamp + batteries", essential: true),
                PackingItem("Emergency whistle"),
                PackingItem("Trekking poles"),
                PackingItem("First aid kit"),
            ]),
            PackingSection(title: "Navigation", icon: "safari.fill", items: [
                PackingItem("Topographic map", essential: true),
                PackingItem("Compass", essential: true),
                PackingItem("GPS or phone with offline maps"),
            ]),
        ],
        medicines: [
            MedicineItem(
                situation: "Allergic Reaction / Insect Sting",
                recommended: MedicineOption(
                    name: "Cetirizine (Zyrtec)",
                    dosage: "10 mg once daily",
                    reason: "Non-drowsy antihistamine — controls allergic reaction without impairing judgment or coordination, which is critical when you still need to navigate or make decisions in the field."
                ),
                avoid: MedicineOption(
                    name: "Diphenhydramine (Benadryl)",
                    dosage: "25–50 mg every 4–6 hrs",
                    reason: "Causes significant sedation and impaired motor control. Taking it in the field reduces your ability to navigate, set up camp, and respond to emergencies. Reserve for nighttime use only."
                )
            ),
            MedicineItem(
                situation: "Anaphylaxis (severe sting or food allergy)",
                recommended: MedicineOption(
                    name: "Epinephrine Auto-Injector (EpiPen)",
                    dosage: "0.3 mg IM into outer thigh; repeat after 5–15 min if needed",
                    reason: "Only medication that reverses anaphylaxis. Acts within 2 minutes. Mandatory if you have a known allergy. Follow with evacuation — epinephrine wears off in 20–30 min."
                ),
                avoid: MedicineOption(
                    name: "Cetirizine or Benadryl alone",
                    dosage: "Any oral antihistamine",
                    reason: "Antihistamines cannot stop the systemic vasodilation and airway swelling of anaphylaxis fast enough. Using them instead of epinephrine delays life-saving treatment."
                )
            ),
            MedicineItem(
                situation: "Diarrhea from contaminated water or food",
                recommended: MedicineOption(
                    name: "Loperamide (Imodium)",
                    dosage: "4 mg initially, then 2 mg after each loose stool; max 16 mg/day",
                    reason: "Slows intestinal motility and reduces fluid loss. Safe for short-term use in the field. Critical in hot or high-exertion environments where dehydration risk is high."
                ),
                avoid: MedicineOption(
                    name: "Bismuth Subsalicylate (Pepto-Bismol)",
                    dosage: "30 mL or 2 tablets every 30–60 min",
                    reason: "Contains salicylate (related to aspirin) — interacts with blood thinners and is less effective at controlling fluid loss than loperamide. Bulky to carry and requires frequent dosing."
                )
            ),
        ]
    ),
    PackingEnvironment(
        id: "hot-desert",
        name: "Hot Desert",
        icon: "sun.max.fill",
        color: .orange,
        tagline: "Arid & high-heat terrain",
        sections: [
            PackingSection(title: "Clothing", icon: "tshirt.fill", items: [
                PackingItem("Loose long-sleeve sun shirts", essential: true, note: "Lightweight fabric blocks UV and reflects heat"),
                PackingItem("Wide-brim hat (3-inch+ brim)", essential: true),
                PackingItem("Lightweight long pants", essential: true),
                PackingItem("Warm layer for nights", essential: true, note: "Desert temps drop 40–50°F after sunset"),
                PackingItem("Gaiters (sand protection)"),
                PackingItem("Bandana or neck gaiter"),
                PackingItem("Light rain jacket (flash flood season)"),
            ]),
            PackingSection(title: "Shelter", icon: "tent.fill", items: [
                PackingItem("Lightweight shade tarp", essential: true, note: "Midday shade is a survival necessity"),
                PackingItem("Tent with good ventilation", essential: true),
                PackingItem("Sleeping bag (30–40°F for cold nights)"),
                PackingItem("Stakes rated for hard or sandy ground"),
                PackingItem("Ground cloth"),
            ]),
            PackingSection(title: "Water & Food", icon: "drop.fill", items: [
                PackingItem("4–6L water capacity", essential: true, note: "Minimum 1 gallon per person per day; more in extreme heat"),
                PackingItem("Electrolyte tablets or powder", essential: true, note: "Salt loss is as dangerous as water loss"),
                PackingItem("Water filter (for springs and potholes)", essential: true),
                PackingItem("Collapsible water containers for camp reserves"),
                PackingItem("Chemical purification backup"),
                PackingItem("High-calorie no-cook or minimal-cook foods", essential: true),
                PackingItem("Salty snacks", essential: true),
                PackingItem("Written water source locations", essential: true),
            ]),
            PackingSection(title: "Safety", icon: "cross.case.fill", items: [
                PackingItem("Sunscreen SPF 50+ (water-resistant)", essential: true),
                PackingItem("Lip balm with SPF", essential: true),
                PackingItem("Signal mirror", essential: true, note: "Visible 10+ miles in desert sunlight"),
                PackingItem("Space blanket (shade and signaling)", essential: true),
                PackingItem("Headlamp (hike early morning and evening)", essential: true),
                PackingItem("Satellite communicator", note: "Cell service is rare in desert wilderness"),
                PackingItem("Emergency whistle"),
                PackingItem("First aid kit with blister care"),
            ]),
            PackingSection(title: "Navigation", icon: "safari.fill", items: [
                PackingItem("Detailed topographic map", essential: true, note: "Desert trails are often faint or unmarked"),
                PackingItem("Compass", essential: true),
                PackingItem("GPS device", essential: true),
                PackingItem("Satellite communicator"),
            ]),
        ],
        medicines: [
            MedicineItem(
                situation: "Headache / Pain while dehydrated",
                recommended: MedicineOption(
                    name: "Ibuprofen (Advil / Motrin)",
                    dosage: "400 mg every 6–8 hrs with food and water",
                    reason: "Effective anti-inflammatory pain reliever. Safer than acetaminophen when mildly dehydrated. Prioritize drinking 500 mL of water when taking it in heat."
                ),
                avoid: MedicineOption(
                    name: "Acetaminophen (Tylenol)",
                    dosage: "500–1000 mg every 4–6 hrs",
                    reason: "Metabolized by the liver, which requires adequate fluid. In severe dehydration, acetaminophen accumulates to toxic levels and causes acute liver damage. Do not use if significantly dehydrated or if urine is dark brown."
                )
            ),
            MedicineItem(
                situation: "Nausea from heat or motion",
                recommended: MedicineOption(
                    name: "Ondansetron (Zofran)",
                    dosage: "4 mg dissolving tablet under the tongue; repeat after 4–6 hrs if needed",
                    reason: "Effective anti-nausea medication with no sedation. Dissolving tablet is ideal when swallowing is difficult. Does not impair your ability to navigate or respond to emergencies."
                ),
                avoid: MedicineOption(
                    name: "Promethazine (Phenergan)",
                    dosage: "12.5–25 mg every 4–6 hrs",
                    reason: "Causes extreme drowsiness and impairs thermoregulation — dangerous in heat where your body needs to sweat and you need to stay alert. Can worsen heat exhaustion progression."
                )
            ),
            MedicineItem(
                situation: "Electrolyte imbalance / dehydration support",
                recommended: MedicineOption(
                    name: "Oral Rehydration Salts (ORS / Pedialyte powder)",
                    dosage: "1 packet per 1L water; sip steadily throughout the day",
                    reason: "Precisely balanced sodium-glucose formula that maximizes water absorption in the intestine. Corrects both fluid and electrolyte loss simultaneously."
                ),
                avoid: MedicineOption(
                    name: "Sports drinks (Gatorade / Powerade)",
                    dosage: "As packaged",
                    reason: "Too high in sugar and too low in sodium for serious dehydration. The high sugar content can cause osmotic diarrhea, worsening fluid loss. Appropriate only for mild sweat replacement, not heat exhaustion treatment."
                )
            ),
        ]
    ),
    PackingEnvironment(
        id: "lush-mountains",
        name: "Lush Mountains",
        icon: "tree.fill",
        color: .indigo,
        tagline: "Temperate forest & alpine terrain",
        sections: [
            PackingSection(title: "Clothing", icon: "tshirt.fill", items: [
                PackingItem("Waterproof rain jacket", essential: true),
                PackingItem("Waterproof rain pants", essential: true),
                PackingItem("Wool or synthetic base layer", essential: true),
                PackingItem("Mid insulation layer (fleece or light down)", essential: true),
                PackingItem("Waterproof hiking boots", essential: true),
                PackingItem("Gaiters (mud and morning dew)"),
                PackingItem("Sun hat + warm hat"),
                PackingItem("Permethrin-treated clothing"),
                PackingItem("Rain cover for backpack"),
            ]),
            PackingSection(title: "Shelter", icon: "tent.fill", items: [
                PackingItem("3-season tent with strong rain fly", essential: true),
                PackingItem("Sleeping bag (20°F rating)", essential: true),
                PackingItem("Insulated sleeping pad"),
                PackingItem("Bear canister or hang rope", essential: true, note: "Required in many national parks"),
                PackingItem("Tent footprint"),
            ]),
            PackingSection(title: "Water & Food", icon: "drop.fill", items: [
                PackingItem("Water filter", essential: true, note: "Sources are abundant but often contaminated"),
                PackingItem("2L water capacity", essential: true),
                PackingItem("Electrolyte tablets"),
                PackingItem("Chemical purification backup"),
                PackingItem("Bear canister (where required)", essential: true),
                PackingItem("Balanced hot meals", essential: true),
                PackingItem("Extra day's emergency rations", essential: true),
                PackingItem("Stove + fuel + cookware"),
            ]),
            PackingSection(title: "Safety", icon: "cross.case.fill", items: [
                PackingItem("Bear spray", essential: true),
                PackingItem("Insect repellent (DEET)", essential: true),
                PackingItem("Tick removal tool", essential: true),
                PackingItem("Trekking poles", note: "Essential on wet, steep, rooted trails"),
                PackingItem("Headlamp + extra batteries", essential: true),
                PackingItem("Emergency bivvy", essential: true),
                PackingItem("Emergency whistle"),
                PackingItem("First aid kit"),
            ]),
            PackingSection(title: "Navigation", icon: "safari.fill", items: [
                PackingItem("Waterproof topographic map", essential: true),
                PackingItem("Compass", essential: true),
                PackingItem("GPS or downloaded offline maps"),
                PackingItem("Satellite communicator", note: "Recommended for multi-day backcountry trips"),
            ]),
        ],
        medicines: [
            MedicineItem(
                situation: "Muscle soreness / joint pain from hiking",
                recommended: MedicineOption(
                    name: "Ibuprofen (Advil / Motrin)",
                    dosage: "400 mg every 6–8 hrs with food",
                    reason: "Reduces inflammation at the source — ideal for the repetitive-stress injuries common on long mountain descents. Anti-inflammatory action speeds recovery between hiking days."
                ),
                avoid: MedicineOption(
                    name: "Aspirin",
                    dosage: "325–650 mg every 4–6 hrs",
                    reason: "Blood-thinning effect increases bruising and bleeding risk on rough terrain. Aspirin also irritates the stomach lining, especially when combined with exertion and reduced food intake on the trail."
                )
            ),
            MedicineItem(
                situation: "GI illness from contaminated water or food",
                recommended: MedicineOption(
                    name: "Loperamide (Imodium)",
                    dosage: "4 mg initially, then 2 mg after each loose stool; max 16 mg/day",
                    reason: "Quickly controls diarrhea and fluid loss, allowing you to maintain hydration and continue moving. Essential on multi-day trips where evacuation is not immediately possible."
                ),
                avoid: MedicineOption(
                    name: "Bismuth Subsalicylate (Pepto-Bismol)",
                    dosage: "30 mL every 30–60 min",
                    reason: "Less effective at controlling fluid loss than loperamide. Contains salicylate (aspirin-related) — causes drug interaction risk, black stools that mask GI bleeding, and requires frequent dosing. Poor trail pharmacology."
                )
            ),
            MedicineItem(
                situation: "Wound care and infection prevention",
                recommended: MedicineOption(
                    name: "Bacitracin or Triple Antibiotic Ointment (Neosporin)",
                    dosage: "Apply thin layer to cleaned wound, cover with bandage; reapply twice daily",
                    reason: "Prevents bacterial colonization of open wounds and keeps tissue moist for faster healing. The standard of care for minor wilderness lacerations and abrasions."
                ),
                avoid: MedicineOption(
                    name: "Hydrogen Peroxide",
                    dosage: "Applied directly to wound",
                    reason: "Destroys the fibroblasts and white blood cells needed to heal the wound — it kills bacteria and healthy tissue equally. Studies show wounds treated with hydrogen peroxide heal slower and scar more than those cleaned with saline or clean water alone."
                )
            ),
        ]
    ),
]

// MARK: - PackingView

struct PackingView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(packingEnvironments) { env in
                        NavigationLink(destination: PackingDetailView(environment: env)) {
                            EnvironmentCard(environment: env)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Pack for Your Trip")
            .background(Color(.systemGroupedBackground))
        }
    }
}

// MARK: - Environment Card

struct EnvironmentCard: View {
    let environment: PackingEnvironment

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [environment.color.opacity(0.85), environment.color.opacity(0.5)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Image(systemName: environment.icon)
                    .font(.system(size: 38, weight: .medium))
                    .foregroundStyle(.white.opacity(0.9))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(environment.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(environment.tagline)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 10)
        }
        .padding(10)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 2)
    }
}

// MARK: - PackingDetailView

struct PackingDetailView: View {
    let environment: PackingEnvironment
    @State private var checkedItems: Set<UUID> = []

    var allItems: [PackingItem] { environment.sections.flatMap(\.items) }
    var checkedCount: Int { checkedItems.count }
    var totalCount: Int { allItems.count }
    var progress: Double { totalCount > 0 ? Double(checkedCount) / Double(totalCount) : 0 }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [environment.color.opacity(0.9), environment.color.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    Image(systemName: environment.icon)
                        .font(.system(size: 100, weight: .thin))
                        .foregroundStyle(.white.opacity(0.15))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 20)
                    VStack(alignment: .leading, spacing: 4) {
                        Image(systemName: environment.icon)
                            .font(.system(size: 32))
                            .foregroundStyle(.white)
                        Text(environment.name)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        Text(environment.tagline)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .frame(height: 150)

                // Progress bar
                VStack(spacing: 8) {
                    HStack {
                        Text("\(checkedCount) of \(totalCount) items packed")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Button("Clear All") { checkedItems.removeAll() }
                            .font(.subheadline)
                            .foregroundStyle(environment.color)
                    }
                    ProgressView(value: progress)
                        .tint(environment.color)
                }
                .padding(.horizontal)
                .padding(.vertical, 14)

                Divider()

                // Sections
                VStack(spacing: 16) {
                    ForEach(environment.sections) { section in
                        PackingSectionCard(
                            section: section,
                            checkedItems: $checkedItems,
                            color: environment.color
                        )
                    }

                    if !environment.medicines.isEmpty {
                        MedicinesSectionCard(
                            medicines: environment.medicines,
                            color: environment.color
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle(environment.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PackingSectionCard

struct PackingSectionCard: View {
    let section: PackingSection
    @Binding var checkedItems: Set<UUID>
    let color: Color

    var sectionChecked: Int { section.items.filter { checkedItems.contains($0.id) }.count }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Section header
            HStack(spacing: 8) {
                Image(systemName: section.icon)
                    .font(.subheadline.bold())
                    .foregroundStyle(color)
                Text(section.title)
                    .font(.subheadline.bold())
                Spacer()
                Text("\(sectionChecked)/\(section.items.count)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(color.opacity(0.08))

            // Items
            ForEach(Array(section.items.enumerated()), id: \.element.id) { index, item in
                PackingItemRow(
                    item: item,
                    isChecked: checkedItems.contains(item.id),
                    color: color
                ) {
                    if checkedItems.contains(item.id) {
                        checkedItems.remove(item.id)
                    } else {
                        checkedItems.insert(item.id)
                    }
                }
                if index < section.items.count - 1 {
                    Divider().padding(.leading, 48)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray5), lineWidth: 1))
    }
}

// MARK: - PackingItemRow

struct PackingItemRow: View {
    let item: PackingItem
    let isChecked: Bool
    let color: Color
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(isChecked ? color : Color(.systemGray3))
                    .animation(.easeInOut(duration: 0.15), value: isChecked)

                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text(item.name)
                            .font(.subheadline)
                            .foregroundStyle(isChecked ? Color(.tertiaryLabel) : .primary)
                            .strikethrough(isChecked, color: Color(.tertiaryLabel))
                        if item.essential && !isChecked {
                            Text("ESSENTIAL")
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 2)
                                .background(color)
                                .clipShape(Capsule())
                        }
                    }
                    if let note = item.note {
                        Text(note)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color(.systemBackground))
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - MedicinesSectionCard

struct MedicinesSectionCard: View {
    let medicines: [MedicineItem]
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Section header
            HStack(spacing: 8) {
                Image(systemName: "pills.fill")
                    .font(.subheadline.bold())
                    .foregroundStyle(color)
                Text("Medicines")
                    .font(.subheadline.bold())
                Spacer()
                Text("\(medicines.count) situations")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(color.opacity(0.08))

            VStack(spacing: 0) {
                ForEach(Array(medicines.enumerated()), id: \.element.id) { index, medicine in
                    MedicineItemCard(medicine: medicine, color: color)
                    if index < medicines.count - 1 {
                        Divider().padding(.leading, 14)
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray5), lineWidth: 1))
    }
}

// MARK: - MedicineItemCard

struct MedicineItemCard: View {
    let medicine: MedicineItem
    let color: Color
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Situation + recommended medicine
            VStack(alignment: .leading, spacing: 8) {
                Text(medicine.situation)
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)

                // Recommended medicine
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                        .font(.callout)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(medicine.recommended.name)
                            .font(.subheadline.bold())
                            .foregroundStyle(.primary)
                        Text(medicine.recommended.dosage)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green.opacity(0.07))
                .clipShape(RoundedRectangle(cornerRadius: 8))

                // Compare button
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.left.arrow.right.circle.fill")
                            .foregroundStyle(color)
                        Text("Compare with commonly misused medicine")
                            .font(.caption.bold())
                            .foregroundStyle(color)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .font(.caption.bold())
                            .foregroundStyle(color)
                    }
                    .padding(.vertical, 2)
                }
                .buttonStyle(.plain)

                // Expanded comparison
                if isExpanded {
                    VStack(spacing: 8) {
                        // Correct
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                    .font(.footnote)
                                Text("USE: \(medicine.recommended.name)")
                                    .font(.caption.bold())
                                    .foregroundStyle(.green)
                            }
                            Text(medicine.recommended.reason)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.07))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                        // Incorrect
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 6) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.red)
                                    .font(.footnote)
                                Text("AVOID: \(medicine.avoid.name)")
                                    .font(.caption.bold())
                                    .foregroundStyle(.red)
                            }
                            Text("Typical dose: \(medicine.avoid.dosage)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text(medicine.avoid.reason)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.07))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding(14)
            .background(Color(.systemBackground))
        }
    }
}
