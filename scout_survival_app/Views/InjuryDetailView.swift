import SwiftUI

// MARK: - Medicine recommendations keyed by injury ID

let injuryMedicines: [String: MedicineItem] = [
    "hypothermia": MedicineItem(
        situation: "Rewarming support",
        recommended: MedicineOption(
            name: "Warm sweet fluids (sugar water, sports drink, warm broth)",
            dosage: "Give only if fully conscious and able to swallow; small sips continuously",
            reason: "Glucose provides immediate fuel for shivering thermogenesis. Warm fluids raise core temperature from the inside and improve energy availability for recovery."
        ),
        avoid: MedicineOption(
            name: "Alcohol (any form)",
            dosage: "Any amount",
            reason: "Alcohol causes peripheral vasodilation — it feels warm but drives blood away from the core to the skin, accelerating heat loss. It also impairs the shivering response and masks the severity of cooling. A common and dangerous field mistake."
        )
    ),
    "heat-exhaustion": MedicineItem(
        situation: "Fluid and electrolyte replacement",
        recommended: MedicineOption(
            name: "Oral Rehydration Salts (ORS / Pedialyte powder)",
            dosage: "1 packet per 1L water; sip steadily — do not gulp",
            reason: "Precisely balanced sodium-glucose ratio maximizes intestinal water absorption. Corrects both fluid and salt loss simultaneously, which plain water cannot do."
        ),
        avoid: MedicineOption(
            name: "Sports drinks (Gatorade / Powerade) as sole treatment",
            dosage: "As packaged",
            reason: "Too high in sugar and too low in sodium for treating heat exhaustion. The excess sugar can cause osmotic diarrhea, worsening fluid loss. Appropriate only for mild prevention, not treatment."
        )
    ),
    "dehydration": MedicineItem(
        situation: "Rehydration",
        recommended: MedicineOption(
            name: "Oral Rehydration Salts (ORS)",
            dosage: "1 packet per 1L of clean water; begin immediately and continue until urine is pale yellow",
            reason: "The WHO-formulated sodium-glucose solution maximizes fluid absorption through active intestinal transport. Superior to plain water for moderate-to-severe dehydration."
        ),
        avoid: MedicineOption(
            name: "Plain water alone (for moderate/severe dehydration)",
            dosage: "Drinking large volumes of plain water",
            reason: "Drinking large amounts of plain water without electrolyte replacement dilutes blood sodium, causing hyponatremia — symptoms include nausea, headache, confusion, and seizure, which mimic dehydration and cause delays in correct treatment."
        )
    ),
    "allergic-reaction": MedicineItem(
        situation: "Anaphylaxis treatment",
        recommended: MedicineOption(
            name: "Epinephrine Auto-Injector (EpiPen)",
            dosage: "0.3 mg IM into outer thigh; repeat after 5–15 min if no improvement; evacuate immediately",
            reason: "The only first-line treatment for anaphylaxis. Reverses bronchospasm, vasodilation, and urticaria within minutes. Without it, anaphylaxis can be fatal in under 15 minutes."
        ),
        avoid: MedicineOption(
            name: "Diphenhydramine (Benadryl) alone",
            dosage: "25–50 mg oral or IM",
            reason: "Antihistamines take 20–30 minutes to absorb orally and cannot reverse airway swelling or systemic vasodilation fast enough. Using it instead of epinephrine delays life-saving treatment. Benadryl is a follow-up, never a replacement."
        )
    ),
    "snake-bite": MedicineItem(
        situation: "Pain management while awaiting evacuation",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400 mg every 6–8 hrs with water",
            reason: "Provides pain relief and mild anti-inflammatory effect. Safe for use while evacuating from a venomous snake bite in the absence of other options."
        ),
        avoid: MedicineOption(
            name: "Aspirin",
            dosage: "Any dose",
            reason: "Many snake venoms already contain anticoagulant compounds. Aspirin's blood-thinning effect compounds this, dramatically increasing internal bleeding risk. Absolutely contraindicated for snake bite patients."
        )
    ),
    "bee-sting": MedicineItem(
        situation: "Allergic reaction / itching from sting",
        recommended: MedicineOption(
            name: "Cetirizine (Zyrtec)",
            dosage: "10 mg once; repeat after 24 hrs if needed",
            reason: "Non-drowsy antihistamine — controls itching and mild allergic response without impairing judgment, coordination, or your ability to navigate and respond to emergencies in the field."
        ),
        avoid: MedicineOption(
            name: "Diphenhydramine (Benadryl)",
            dosage: "25–50 mg every 4–6 hrs",
            reason: "Causes significant sedation and motor impairment for 4–6 hours. In the field this reduces your ability to navigate, set up camp, and recognize worsening anaphylaxis. Use cetirizine during the day; Benadryl only if needed at night."
        )
    ),
    "spider-bite": MedicineItem(
        situation: "Pain and inflammation management",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400 mg every 6–8 hrs with food",
            reason: "Controls local pain and inflammation at the bite site. Anti-inflammatory action is particularly useful for black widow bites, where muscle cramping and localized swelling are the main symptoms."
        ),
        avoid: MedicineOption(
            name: "Diphenhydramine (Benadryl) as primary treatment",
            dosage: "25–50 mg",
            reason: "Antihistamines do not address the neurotoxic or necrotic venom components of medically significant spiders. Relying on Benadryl delays recognition of worsening symptoms and evacuation for antivenom administration."
        )
    ),
    "tick-bite": MedicineItem(
        situation: "Lyme disease prophylaxis (within 72 hours of tick removal)",
        recommended: MedicineOption(
            name: "Doxycycline (prescribed)",
            dosage: "200 mg single dose, taken within 72 hours of tick removal",
            reason: "CDC-recommended single-dose prophylaxis for Lyme disease after deer tick bite. Only effective within 72 hours. Requires a prescription — arrange before trips in endemic areas."
        ),
        avoid: MedicineOption(
            name: "Amoxicillin or leftover antibiotics",
            dosage: "Any self-prescribed course",
            reason: "Amoxicillin requires a full 21-day course to treat established Lyme — a single prophylactic dose is ineffective. Using random leftover antibiotics risks incorrect dosing, bacterial resistance, and missing a concurrent infection. Always use the prescribed single-dose doxycycline regimen."
        )
    ),
    "fracture": MedicineItem(
        situation: "Pain management",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400–600 mg every 6–8 hrs with food",
            reason: "Reduces both fracture pain and the associated soft-tissue inflammation. Anti-inflammatory effect helps control swelling around the break, improving comfort during splinting and evacuation."
        ),
        avoid: MedicineOption(
            name: "Aspirin",
            dosage: "325–650 mg",
            reason: "Inhibits platelet aggregation — increases bleeding into the fracture site, worsening hematoma formation and swelling. Contraindicated for any acute traumatic injury where internal bleeding is likely."
        )
    ),
    "sprain": MedicineItem(
        situation: "Inflammation and pain from ligament injury",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400 mg every 6–8 hrs with food for up to 5 days",
            reason: "NSAID with proven anti-inflammatory effect — directly addresses the cause of pain (inflammation), reduces swelling, and improves range of motion. Preferred over acetaminophen for acute soft-tissue injuries."
        ),
        avoid: MedicineOption(
            name: "Acetaminophen (Tylenol)",
            dosage: "500–1000 mg every 4–6 hrs",
            reason: "Acetaminophen is a pain reliever only — it has no anti-inflammatory effect. It does not reduce swelling or address the underlying ligament inflammation, making it significantly less effective than ibuprofen for sprains."
        )
    ),
    "blister": MedicineItem(
        situation: "Infection prevention after draining or rupture",
        recommended: MedicineOption(
            name: "Bacitracin or Triple Antibiotic Ointment (Neosporin)",
            dosage: "Apply thin layer to drained or opened blister; cover with non-stick dressing; reapply twice daily",
            reason: "Prevents bacterial colonization and keeps the exposed tissue moist, which accelerates healing and reduces scarring. The standard of care for open blisters in the field."
        ),
        avoid: MedicineOption(
            name: "Hydrogen Peroxide",
            dosage: "Applied directly to blister",
            reason: "Destroys the fibroblasts and immune cells needed for healing — it damages healthy tissue as effectively as bacteria. Hydrogen peroxide–treated wounds heal more slowly and develop more scarring. Clean with saline or clean water, not peroxide."
        )
    ),
    "wound-laceration": MedicineItem(
        situation: "Wound infection prevention",
        recommended: MedicineOption(
            name: "Triple Antibiotic Ointment (Neosporin / Bacitracin)",
            dosage: "Apply thin layer after cleaning; reapply with each dressing change (1–2× daily)",
            reason: "Creates an antibacterial barrier, keeps the wound moist for optimal healing, and reduces infection risk. Moist wound healing is proven to reduce healing time and scarring compared to dry methods."
        ),
        avoid: MedicineOption(
            name: "Hydrogen Peroxide or Iodine directly in wound",
            dosage: "Applied directly to open tissue",
            reason: "Both hydrogen peroxide and full-strength iodine destroy the fibroblasts, white blood cells, and granulation tissue essential for healing. They are cytotoxic — they kill the cells trying to heal the wound. Use only diluted iodine (0.5%) for irrigation if clean water is unavailable."
        )
    ),
    "burn": MedicineItem(
        situation: "Pain management and inflammation",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400 mg every 6–8 hrs with food and water",
            reason: "Reduces burn pain and the inflammatory response in surrounding tissue. Anti-inflammatory action limits secondary tissue damage beyond the burn margin. Oral ibuprofen is the first-line analgesic for moderate burns in the field."
        ),
        avoid: MedicineOption(
            name: "Topical anesthetics (benzocaine sprays like Solarcaine)",
            dosage: "Applied directly to burn",
            reason: "Benzocaine can cause methemoglobinemia — a dangerous condition where the blood loses its ability to carry oxygen. It also masks pain that is needed to assess burn depth progression. Topical anesthetics are contraindicated on open burn wounds."
        )
    ),
    "sunburn": MedicineItem(
        situation: "Inflammation and pain from UV damage",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400 mg every 6–8 hrs, starting as soon as possible after sun exposure",
            reason: "Sunburn is an inflammatory response — ibuprofen treats the cause directly. Starting early, before blistering begins, significantly reduces severity, pain duration, and peeling. Most effective when taken within hours of exposure."
        ),
        avoid: MedicineOption(
            name: "Topical benzocaine sprays (Solarcaine, Dermoplast)",
            dosage: "Sprayed on burned skin",
            reason: "Provides only brief topical numbing with no effect on the underlying inflammation. Can cause allergic contact dermatitis in some people, and in large applications over broken skin, carries risk of systemic benzocaine toxicity."
        )
    ),
    "frostbite": MedicineItem(
        situation: "Pain during rewarming and tissue protection",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "400 mg every 12 hrs (not every 6–8 hrs); continue through rewarming",
            reason: "Ibuprofen inhibits thromboxane and prostaglandins that cause further microvascular damage during frostbite rewarming. Proven in clinical studies to reduce tissue loss when given early and continued through recovery."
        ),
        avoid: MedicineOption(
            name: "Aspirin",
            dosage: "Any dose",
            reason: "Aspirin's anticoagulant effect increases bleeding risk in already-damaged microvascular tissue. Unlike ibuprofen, aspirin does not block the specific inflammatory pathways that worsen frostbite progression. Contraindicated for frostbite patients."
        )
    ),
    "giardia": MedicineItem(
        situation: "Treatment of active Giardia infection",
        recommended: MedicineOption(
            name: "Metronidazole (Flagyl) — requires prescription",
            dosage: "250 mg three times daily for 5–7 days, or 2 g as a single dose",
            reason: "First-line antiparasitic for Giardia. Directly kills the Giardia lamblia protozoa. Arrange a prescription before remote trips in regions with high Giardia prevalence."
        ),
        avoid: MedicineOption(
            name: "Loperamide (Imodium) alone",
            dosage: "2–4 mg per dose",
            reason: "Loperamide controls diarrhea symptoms by slowing gut motility but does nothing to eliminate the Giardia parasite. Using it alone allows the infection to continue and worsen. It may be used as a short-term symptomatic bridge while arranging evacuation, but is not a treatment."
        )
    ),
    "altitude-sickness": MedicineItem(
        situation: "Prevention and treatment of Acute Mountain Sickness (AMS)",
        recommended: MedicineOption(
            name: "Acetazolamide (Diamox) — requires prescription",
            dosage: "125–250 mg twice daily, starting 24 hrs before ascent; continue for 2 days at altitude",
            reason: "Stimulates faster and deeper breathing, speeding acclimatization. Proven to prevent AMS in clinical trials and to treat mild-to-moderate AMS. The standard recommendation from wilderness medicine authorities."
        ),
        avoid: MedicineOption(
            name: "Ibuprofen alone",
            dosage: "600 mg every 8 hrs",
            reason: "Ibuprofen reduces the headache of AMS but does not address the underlying impaired acclimatization. The disease continues to progress silently while symptoms feel managed. Descent is required for worsening AMS regardless of pain relief."
        )
    ),
    "head-injury": MedicineItem(
        situation: "Pain management after concussion or head injury",
        recommended: MedicineOption(
            name: "Acetaminophen (Tylenol)",
            dosage: "500–1000 mg every 4–6 hrs; do not exceed 4 g/day",
            reason: "Only safe analgesic after head injury. Controls headache without affecting bleeding or clotting. Widely recommended by wilderness medicine and neurology guidelines for post-concussion pain management."
        ),
        avoid: MedicineOption(
            name: "Ibuprofen or Aspirin (any NSAID)",
            dosage: "Any dose",
            reason: "NSAIDs and aspirin inhibit platelet function, increasing the risk of intracranial bleeding after head trauma. A small subdural or epidural bleed can expand catastrophically with anticoagulant medication. Absolutely contraindicated following any significant head injury."
        )
    ),
    "puncture-wound": MedicineItem(
        situation: "Infection prevention in deep puncture wounds",
        recommended: MedicineOption(
            name: "Triple Antibiotic Ointment after thorough irrigation",
            dosage: "Apply after irrigating wound with clean water under pressure; do not pack deep wounds with ointment",
            reason: "Prevents surface colonization while the wound drains from within. Irrigation with clean water under pressure (use a syringe if available) is the most important step — ointment alone without irrigation is insufficient."
        ),
        avoid: MedicineOption(
            name: "Hydrogen Peroxide poured into the wound",
            dosage: "Applied directly",
            reason: "Hydrogen peroxide cannot reach anaerobic bacteria deep in a puncture track, and it destroys the tissue it contacts. Puncture wounds need mechanical irrigation with water — peroxide provides no benefit at depth and actively damages the tissue."
        )
    ),
    "cardiac-arrest": MedicineItem(
        situation: "Suspected heart attack (chest pain, not cardiac arrest)",
        recommended: MedicineOption(
            name: "Aspirin (for suspected myocardial infarction only)",
            dosage: "325 mg chewed (not swallowed whole), given once at symptom onset",
            reason: "Aspirin inhibits platelet aggregation, slowing the growth of the coronary artery clot causing the heart attack. Given as early as possible, it reduces mortality. Chewing maximizes absorption speed."
        ),
        avoid: MedicineOption(
            name: "Ibuprofen or naproxen (NSAIDs other than aspirin)",
            dosage: "Any dose",
            reason: "Non-aspirin NSAIDs increase cardiovascular risk and can worsen a heart attack by increasing platelet aggregation via different pathways. Studies show they significantly increase risk of re-infarction. Only aspirin has the correct mechanism for this specific emergency."
        )
    ),
    "shoulder-dislocation": MedicineItem(
        situation: "Pain management before and after reduction",
        recommended: MedicineOption(
            name: "Ibuprofen (Advil / Motrin)",
            dosage: "600 mg every 6–8 hrs with food",
            reason: "Reduces joint inflammation and muscle spasm around the shoulder, easing pain before and after reduction. Anti-inflammatory effect helps manage the significant soft-tissue injury that accompanies dislocation."
        ),
        avoid: MedicineOption(
            name: "Aspirin",
            dosage: "325–650 mg",
            reason: "Increases bleeding into the joint capsule and surrounding soft tissue, worsening hematoma formation and extending recovery time. The same anticoagulant risk that applies to fractures applies here — avoid aspirin for any acute joint injury."
        )
    ),
    "shock": MedicineItem(
        situation: "What NOT to give — fluid management",
        recommended: MedicineOption(
            name: "Oral fluids (if conscious and no abdominal injury)",
            dosage: "Small frequent sips only if fully alert, no nausea, no suspected abdominal trauma",
            reason: "Maintaining circulating volume is critical. If the patient is conscious and can swallow safely, oral fluids help maintain blood pressure until evacuation. Lay flat with legs elevated unless spinal injury is suspected."
        ),
        avoid: MedicineOption(
            name: "Any oral medication or fluids (if unconscious or has abdominal injury)",
            dosage: "N/A — nothing by mouth",
            reason: "Unconscious patients cannot protect their airway — oral fluids or medication will cause aspiration. Suspected abdominal trauma requires surgical intervention; oral fluids can worsen internal bleeding and complicate surgery. Nothing by mouth until a physician evaluates."
        )
    ),
]

struct InjuryDetailView: View {
    let injury: Injury

    var severityColor: Color {
        switch injury.severity {
        case .minor: return .green
        case .moderate: return .yellow
        case .serious: return .orange
        case .lifeThreatening: return .red
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Severity banner
                HStack {
                    Image(systemName: injury.category.icon)
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text(injury.category.rawValue)
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Text(injury.severity.rawValue)
                            .font(.headline.bold())
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: injury.severity == .lifeThreatening ? "exclamationmark.triangle.fill" : "info.circle.fill")
                        .font(.title2)
                }
                .foregroundColor(.white)
                .padding()
                .background(severityColor.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)

                // Symptoms
                InjurySection(title: "Symptoms", icon: "list.bullet.circle.fill", color: .blue) {
                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(injury.symptoms, id: \.self) { symptom in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.blue)
                                    .padding(.top, 6)
                                Text(symptom)
                                    .font(.body)
                            }
                        }
                    }
                }

                // Immediate actions
                if !injury.immediateActions.isEmpty {
                    InjurySection(title: "Immediate Actions", icon: "bolt.fill", color: .orange) {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(Array(injury.immediateActions.enumerated()), id: \.offset) { i, action in
                                HStack(alignment: .top, spacing: 10) {
                                    Text("\(i + 1)")
                                        .font(.caption.bold())
                                        .foregroundColor(.white)
                                        .frame(width: 22, height: 22)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                    Text(action)
                                        .font(.body)
                                }
                            }
                        }
                    }
                }

                // Step-by-step treatment
                if !injury.treatments.isEmpty {
                    InjurySection(title: "Treatment Steps", icon: "cross.case.fill", color: .green) {
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(injury.treatments.sorted { $0.step < $1.step }) { treatment in
                                TreatmentStepView(treatment: treatment)
                            }
                        }
                    }
                }

                // Warning signs
                if !injury.warningSigns.isEmpty {
                    InjurySection(title: "Warning Signs", icon: "exclamationmark.triangle.fill", color: .red) {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(injury.warningSigns, id: \.self) { sign in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                        .padding(.top, 3)
                                    Text(sign)
                                        .font(.body)
                                }
                            }
                        }
                    }
                }

                // When to evacuate
                if !injury.whenToEvacuate.isEmpty {
                    InjurySection(title: "When to Evacuate", icon: "figure.run", color: .purple) {
                        Text(injury.whenToEvacuate)
                            .font(.body)
                    }
                }

                // Prevention
                if !injury.preventionTips.isEmpty {
                    InjurySection(title: "Prevention", icon: "shield.checkered", color: .teal) {
                        VStack(alignment: .leading, spacing: 6) {
                            ForEach(injury.preventionTips, id: \.self) { tip in
                                HStack(alignment: .top, spacing: 8) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.teal)
                                        .font(.caption)
                                        .padding(.top, 3)
                                    Text(tip)
                                        .font(.body)
                                }
                            }
                        }
                    }
                }

                // Medicines
                if let medicine = injuryMedicines[injury.id] {
                    InjurySection(title: "Medicines", icon: "pills.fill", color: severityColor) {
                        MedicineItemCard(medicine: medicine, color: severityColor)
                    }
                }
            }
            .padding(.bottom, 20)
        }
        .navigationTitle(injury.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InjurySection<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.headline)
            }
            content
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

struct TreatmentStepView: View {
    let treatment: Treatment

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .top, spacing: 10) {
                Text("Step \(treatment.step)")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.green)
                    .clipShape(Capsule())
                Text(treatment.description)
                    .font(.body)
            }

            if !treatment.materials.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "bag.fill")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("Materials: \(treatment.materials.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 60)
            }

            if let notes = treatment.notes {
                Text("Note: \(notes)")
                    .font(.caption)
                    .foregroundColor(.orange)
                    .padding(.leading, 60)
            }
        }
        .padding(.vertical, 4)
    }
}
