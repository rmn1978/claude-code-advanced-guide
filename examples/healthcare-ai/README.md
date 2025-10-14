# 🏥 Healthcare AI Application

Una aplicación completa de IA médica con Claude Code, incluyendo análisis de síntomas, generación de diagnósticos diferenciales e integración con estándares médicos (FHIR, ICD-10).

## 🎯 Características

- ✅ Análisis de síntomas con procesamiento de lenguaje natural
- ✅ Generación de diagnósticos diferenciales
- ✅ Integración con FHIR (Fast Healthcare Interoperability Resources)
- ✅ Codificación ICD-10 automática
- ✅ Verificación de interacciones medicamentosas
- ✅ Generación de reportes médicos
- ✅ Cumplimiento con HIPAA

## ⚠️ Disclaimer Médico

**IMPORTANTE**: Esta es una aplicación de demostración con fines educativos. NO debe usarse para diagnósticos médicos reales. Siempre consulte con profesionales de la salud licenciados para cualquier inquietud médica.

## 🏗️ Arquitectura

```
healthcare-ai/
├── .claude/
│   ├── agents/
│   │   ├── medical-diagnostic.md
│   │   ├── fhir-specialist.md
│   │   ├── drug-interaction-checker.md
│   │   └── medical-coder.md
│   ├── commands/
│   │   ├── analyze-symptoms.md
│   │   ├── generate-report.md
│   │   └── check-interactions.md
│   └── settings.json
├── CLAUDE.md
├── src/
│   ├── api/
│   │   ├── patients/
│   │   ├── diagnostics/
│   │   └── prescriptions/
│   ├── services/
│   │   ├── symptom-analyzer.ts
│   │   ├── diagnosis-generator.ts
│   │   ├── fhir-service.ts
│   │   └── icd10-mapper.ts
│   ├── models/
│   │   ├── patient.model.ts
│   │   ├── symptom.model.ts
│   │   └── diagnosis.model.ts
│   └── utils/
│       ├── medical-nlp.ts
│       └── hipaa-logger.ts
├── tests/
└── docs/
```

## 🚀 Setup Rápido

### 1. Instalar Dependencias

\`\`\`bash
# Clonar configuración
cp -r healthcare-ai/.claude ~/.claude-healthcare

# Instalar proyecto
npm install

# Setup base de datos
npm run db:migrate

# Variables de entorno
cp .env.example .env
# Editar .env con tus credenciales
\`\`\`

### 2. Iniciar Claude Code

\`\`\`bash
cd healthcare-ai
claude

# Claude leerá automáticamente:
# - CLAUDE.md con convenciones médicas
# - .claude/agents/ con agentes especializados
# - .claude/settings.json con configuración
\`\`\`

### 3. Usar Comandos Médicos

\`\`\`bash
# Analizar síntomas
/project:analyze-symptoms "Patient reports fever, cough, and fatigue for 3 days"

# Generar reporte médico
/project:generate-report patient-123

# Verificar interacciones
/project:check-interactions "Aspirin, Warfarin, Ibuprofen"
\`\`\`

## 🤖 Agentes Especializados

### 1. Medical Diagnostic Agent

**Especialidad**: Análisis de síntomas y generación de diagnósticos diferenciales

\`\`\`markdown
---
name: medical-diagnostic
description: Analyze symptoms and generate differential diagnoses
tools: Read, Write, WebSearch
model: opus
---
\`\`\`

**Uso**:
\`\`\`bash
> Use the medical-diagnostic agent to analyze these symptoms:
> - Fever (39°C) for 3 days
> - Dry cough
> - Fatigue
> - Headache
> - No recent travel
\`\`\`

**Output Esperado**:
\`\`\`markdown
## Differential Diagnosis

### 1. Viral Upper Respiratory Infection (Probability: High)
**ICD-10**: J06.9
**Supporting Features**:
- Fever, cough, fatigue (classic triad)
- Duration consistent with viral illness
- No red flags

**Recommended Workup**:
- Symptomatic treatment
- Rest and hydration
- Follow-up if worsens

### 2. Influenza (Probability: Moderate-High)
**ICD-10**: J11.1
**Supporting Features**:
- Acute onset
- Fever and systemic symptoms
- Seasonal pattern

**Recommended Workup**:
- Rapid flu test if within 48h of onset
- Consider antivirals if positive

### 3. COVID-19 (Probability: Moderate)
**ICD-10**: U07.1
**Supporting Features**:
- Fever and cough
- Fatigue prominent

**Recommended Workup**:
- COVID-19 PCR test
- Isolation pending results

### Red Flags to Monitor
⚠️ Seek immediate care if:
- Difficulty breathing
- Chest pain
- Confusion
- Persistent high fever > 3 days
\`\`\`

### 2. FHIR Specialist Agent

**Especialidad**: Manejo de recursos FHIR y conversión de datos

\`\`\`markdown
---
name: fhir-specialist
description: Expert in FHIR resources, conversions, and healthcare data standards
tools: Read, Write, Edit
model: sonnet
---
\`\`\`

**Uso**:
\`\`\`bash
> Convert this patient data to FHIR format:
> Name: John Doe
> DOB: 1985-05-15
> Gender: Male
> Diagnosis: Type 2 Diabetes (E11.9)
\`\`\`

**Output**:
\`\`\`json
{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "resource": {
        "resourceType": "Patient",
        "id": "patient-001",
        "identifier": [{
          "system": "http://hospital.org/patients",
          "value": "12345"
        }],
        "name": [{
          "use": "official",
          "family": "Doe",
          "given": ["John"]
        }],
        "gender": "male",
        "birthDate": "1985-05-15"
      },
      "request": {
        "method": "POST",
        "url": "Patient"
      }
    },
    {
      "resource": {
        "resourceType": "Condition",
        "id": "condition-001",
        "clinicalStatus": {
          "coding": [{
            "system": "http://terminology.hl7.org/CodeSystem/condition-clinical",
            "code": "active"
          }]
        },
        "verificationStatus": {
          "coding": [{
            "system": "http://terminology.hl7.org/CodeSystem/condition-ver-status",
            "code": "confirmed"
          }]
        },
        "code": {
          "coding": [{
            "system": "http://hl7.org/fhir/sid/icd-10",
            "code": "E11.9",
            "display": "Type 2 diabetes mellitus without complications"
          }],
          "text": "Type 2 Diabetes"
        },
        "subject": {
          "reference": "Patient/patient-001"
        },
        "onsetDateTime": "2024-01-15"
      },
      "request": {
        "method": "POST",
        "url": "Condition"
      }
    }
  ]
}
\`\`\`

### 3. Drug Interaction Checker

**Especialidad**: Verificar interacciones medicamentosas y contraindicaciones

\`\`\`markdown
---
name: drug-interaction-checker
description: Check drug interactions and contraindications
tools: Read, WebSearch
model: sonnet
---
\`\`\`

**Uso**:
\`\`\`bash
> Check interactions for:
> - Warfarin 5mg daily
> - Aspirin 81mg daily
> - Patient: 65 years old, renal impairment
\`\`\`

**Output**:
\`\`\`markdown
## Drug Interaction Report

### 🚨 CRITICAL INTERACTION

**Drugs**: Warfarin + Aspirin
**Severity**: Major
**Risk**: Increased bleeding risk

**Mechanism**:
- Both are anticoagulants
- Aspirin inhibits platelet function
- Warfarin inhibits clotting factors
- Combined effect is synergistic

**Recommendation**:
- ⚠️ Use only under close medical supervision
- Monitor INR more frequently
- Watch for signs of bleeding
- Consider alternative to aspirin if possible
- Patient education on bleeding signs

**Monitoring**:
- INR: Check weekly initially, then per protocol
- CBC: Monitor for anemia
- Signs of bleeding: Daily patient self-check

### ⚠️ RENAL IMPAIRMENT CONSIDERATIONS

**Warfarin**:
- May require dose adjustment
- Increased sensitivity in renal impairment
- More frequent INR monitoring

**Aspirin**:
- Generally safe in renal impairment
- Consider lower dose if GFR < 30

### Patient Education
1. Report any unusual bruising or bleeding
2. Avoid NSAIDs (ibuprofen, naproxen)
3. Inform all healthcare providers
4. Maintain consistent vitamin K intake
5. Use soft toothbrush
6. Avoid contact sports
\`\`\`

### 4. Medical Coder Agent

**Especialidad**: Codificación ICD-10, CPT, y billing

\`\`\`markdown
---
name: medical-coder
description: Expert in ICD-10, CPT coding, and medical billing
tools: Read, Write, WebSearch
model: sonnet
---
\`\`\`

**Uso**:
\`\`\`bash
> Code this encounter:
> Chief Complaint: Chest pain
> Diagnosis: Acute myocardial infarction, anterior wall
> Procedures: ECG, Cardiac catheterization with stent placement
\`\`\`

**Output**:
\`\`\`markdown
## Medical Coding Summary

### Diagnosis Codes (ICD-10)

**Primary Diagnosis**:
- **I21.09**: ST elevation (STEMI) myocardial infarction involving other coronary artery of anterior wall

**Secondary Diagnoses** (if applicable):
- I25.10: Atherosclerotic heart disease (if documented)
- I10: Essential hypertension (if documented)
- E78.5: Hyperlipidemia (if documented)

### Procedure Codes (CPT)

**Cardiac Catheterization**:
- **93454**: Catheter placement in coronary artery(s) for coronary angiography
- **92928**: Percutaneous transcatheter placement of intracoronary stent(s), with coronary angioplasty when performed; single major coronary artery or branch

**Diagnostic Tests**:
- **93000**: Electrocardiogram, routine ECG with at least 12 leads; with interpretation and report

### DRG (Diagnosis Related Group)
- **DRG 247**: Percutaneous cardiovascular procedures with drug-eluting stent, with AMI, without MCC

### Documentation Requirements
✅ **For proper reimbursement, ensure documentation includes**:
- Time of onset of chest pain
- ECG findings (ST elevation location)
- Cardiac enzyme levels (Troponin)
- Specific coronary artery involved
- Stent type (drug-eluting vs bare metal)
- Pre and post procedure stenosis percentage
- Any complications

### Revenue Cycle Notes
- **Expected Reimbursement**: $XX,XXX (varies by payer)
- **Length of Stay**: 2-3 days typical
- **Follow-up**: 30-day post-discharge visit required
\`\`\`

## 📋 Comandos Personalizados

### /project:analyze-symptoms

\`\`\`markdown
<!-- .claude/commands/analyze-symptoms.md -->

You are analyzing patient symptoms. Follow this structured approach:

## Input Analysis
Parse symptoms: $ARGUMENTS

## Step 1: Symptom Extraction
List all symptoms mentioned:
- Primary symptoms
- Secondary symptoms
- Duration and severity
- Relevant negatives

## Step 2: Pattern Recognition
Identify symptom clusters that suggest specific conditions.

## Step 3: Differential Diagnosis
Use the medical-diagnostic agent to generate:
1. Top 3-5 most likely diagnoses
2. ICD-10 codes
3. Supporting/refuting features
4. Recommended workup

## Step 4: Red Flags
Identify any alarming symptoms requiring immediate attention.

## Step 5: Next Steps
- Recommended tests
- Specialist referrals
- Timeline for follow-up
- Patient education points

Output in structured markdown format.
\`\`\`

**Ejemplo de uso**:
\`\`\`bash
/project:analyze-symptoms "32-year-old female with severe headache, photophobia, neck stiffness, and fever"

# Output incluirá análisis completo con diagnóstico diferencial
# priorizando meningitis (red flag) y migraña
\`\`\`

### /project:generate-report

\`\`\`markdown
<!-- .claude/commands/generate-report.md -->

Generate a comprehensive medical report for patient: $ARGUMENTS

## Report Structure

### Patient Demographics
- Name, DOB, MRN
- Contact information
- Insurance details

### Chief Complaint
[From patient record]

### History of Present Illness (HPI)
[Detailed narrative]

### Past Medical History (PMH)
- Prior conditions
- Surgeries
- Hospitalizations

### Medications
- Current medications with dosages
- Drug interactions (use drug-interaction-checker agent)

### Allergies
- Drug allergies
- Environmental allergies

### Social History
- Smoking, alcohol, drugs
- Occupation
- Living situation

### Family History
- Relevant hereditary conditions

### Review of Systems
- Constitutional
- Cardiovascular
- Respiratory
- Gastrointestinal
- [... other systems ...]

### Physical Examination
[From examination notes]

### Assessment and Plan
- Primary diagnosis with ICD-10 (use medical-coder agent)
- Differential diagnoses
- Treatment plan
- Follow-up instructions

### Signature
[Provider name and credentials]

Format in professional medical report style.
\`\`\`

### /project:check-interactions

\`\`\`markdown
<!-- .claude/commands/check-interactions.md -->

Check drug interactions for: $ARGUMENTS

Use the drug-interaction-checker agent to:

1. Parse drug list
2. Check pairwise interactions
3. Identify severity levels
4. Provide clinical recommendations
5. Suggest monitoring parameters
6. Generate patient education material

Include:
- Interaction severity (major/moderate/minor)
- Mechanism of interaction
- Clinical effects
- Management recommendations
\`\`\`

## 🗄️ Modelos de Datos

### Patient Model

\`\`\`typescript
// src/models/patient.model.ts

export interface Patient {
  id: string;
  mrn: string; // Medical Record Number

  // Demographics
  firstName: string;
  lastName: string;
  dateOfBirth: Date;
  gender: 'male' | 'female' | 'other' | 'unknown';

  // Contact
  email?: string;
  phone?: string;
  address?: Address;

  // Medical
  allergies: Allergy[];
  medications: Medication[];
  conditions: Condition[];

  // FHIR
  fhirId?: string;

  // Audit
  createdAt: Date;
  updatedAt: Date;
}

export interface Allergy {
  substance: string;
  reaction: string;
  severity: 'mild' | 'moderate' | 'severe';
  onsetDate?: Date;
}

export interface Medication {
  name: string;
  dosage: string;
  frequency: string;
  startDate: Date;
  endDate?: Date;
  prescribedBy: string;
}

export interface Condition {
  code: string; // ICD-10
  display: string;
  clinicalStatus: 'active' | 'resolved' | 'inactive';
  onsetDate: Date;
  resolvedDate?: Date;
}
\`\`\`

### Symptom Analysis Model

\`\`\`typescript
// src/models/symptom.model.ts

export interface SymptomAnalysis {
  id: string;
  patientId: string;

  // Input
  chiefComplaint: string;
  symptoms: Symptom[];
  duration: string;

  // Output
  differentialDiagnoses: DifferentialDiagnosis[];
  redFlags: RedFlag[];
  recommendedWorkup: string[];

  // Meta
  analyzedAt: Date;
  analyzedBy: string; // Agent or user
}

export interface Symptom {
  name: string;
  severity: 1 | 2 | 3 | 4 | 5; // 1=mild, 5=severe
  onset: Date;
  duration: string;
  quality?: string;
  location?: string;
  radiation?: string;
  associatedSymptoms: string[];
  aggravatingFactors?: string[];
  relievingFactors?: string[];
}

export interface DifferentialDiagnosis {
  condition: string;
  icd10Code: string;
  probability: 'high' | 'moderate' | 'low';
  supportingFeatures: string[];
  refutingFeatures: string[];
  nextSteps: string[];
}

export interface RedFlag {
  symptom: string;
  concern: string;
  action: string;
  urgency: 'immediate' | 'urgent' | 'routine';
}
\`\`\`

## 🧪 Testing

### Test Structure

\`\`\`bash
tests/
├── unit/
│   ├── symptom-analyzer.test.ts
│   ├── icd10-mapper.test.ts
│   └── drug-interaction.test.ts
├── integration/
│   ├── diagnosis-workflow.test.ts
│   └── fhir-api.test.ts
└── e2e/
    └── patient-journey.test.ts
\`\`\`

### Ejemplo: Test de Análisis de Síntomas

\`\`\`typescript
// tests/unit/symptom-analyzer.test.ts

import { SymptomAnalyzer } from '@/services/symptom-analyzer';

describe('SymptomAnalyzer', () => {
  let analyzer: SymptomAnalyzer;

  beforeEach(() => {
    analyzer = new SymptomAnalyzer();
  });

  describe('analyze', () => {
    it('should identify potential meningitis from classic triad', async () => {
      const symptoms = [
        { name: 'headache', severity: 5 },
        { name: 'neck stiffness', severity: 4 },
        { name: 'fever', severity: 4 }
      ];

      const result = await analyzer.analyze(symptoms);

      expect(result.differentialDiagnoses).toContainEqual(
        expect.objectContaining({
          condition: expect.stringContaining('meningitis'),
          probability: 'high'
        })
      );

      expect(result.redFlags).toHaveLength(1);
      expect(result.redFlags[0].urgency).toBe('immediate');
    });

    it('should generate ICD-10 codes for diagnoses', async () => {
      const symptoms = [
        { name: 'cough', severity: 3 },
        { name: 'fever', severity: 2 }
      ];

      const result = await analyzer.analyze(symptoms);

      expect(result.differentialDiagnoses[0].icd10Code).toMatch(/^[A-Z]\\d{2}/);
    });

    it('should recommend appropriate workup', async () => {
      const symptoms = [
        { name: 'chest pain', severity: 5 },
        { name: 'shortness of breath', severity: 4 }
      ];

      const result = await analyzer.analyze(symptoms);

      expect(result.recommendedWorkup).toContain('ECG');
      expect(result.recommendedWorkup).toContain('Cardiac enzymes');
    });
  });
});
\`\`\`

## 🔐 Seguridad y Cumplimiento

### HIPAA Compliance

\`\`\`typescript
// src/utils/hipaa-logger.ts

import winston from 'winston';

// HIPAA-compliant logger
// NO logs PHI (Protected Health Information)
export const logger = winston.createLogger({
  level: 'info',
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [
    new winston.transports.File({ filename: 'audit.log' })
  ]
});

// Safe to log (no PHI)
logger.info('Patient record accessed', {
  userId: 'user-123',
  patientId: 'patient-456', // ID is okay
  action: 'view',
  timestamp: new Date()
});

// NEVER log (contains PHI)
// ❌ logger.info('Patient John Doe accessed');
// ❌ logger.info('SSN: 123-45-6789');
// ❌ logger.info('Diagnosis: HIV positive');
\`\`\`

### Encriptación

\`\`\`typescript
// src/utils/encryption.ts

import crypto from 'crypto';

const ALGORITHM = 'aes-256-gcm';
const KEY = Buffer.from(process.env.ENCRYPTION_KEY!, 'hex');

export function encrypt(text: string): string {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv(ALGORITHM, KEY, iv);

  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');

  const authTag = cipher.getAuthTag();

  return iv.toString('hex') + ':' + authTag.toString('hex') + ':' + encrypted;
}

export function decrypt(encrypted: string): string {
  const parts = encrypted.split(':');
  const iv = Buffer.from(parts[0], 'hex');
  const authTag = Buffer.from(parts[1], 'hex');
  const encryptedText = parts[2];

  const decipher = crypto.createDecipheriv(ALGORITHM, KEY, iv);
  decipher.setAuthTag(authTag);

  let decrypted = decipher.update(encryptedText, 'hex', 'utf8');
  decrypted += decipher.final('utf8');

  return decrypted;
}
\`\`\`

## 📚 Referencias y Recursos

### Estándares Médicos
- **FHIR**: https://www.hl7.org/fhir/
- **ICD-10**: https://www.who.int/classifications/icd/
- **SNOMED CT**: https://www.snomed.org/
- **LOINC**: https://loinc.org/

### Bases de Datos Médicas
- **PubMed**: https://pubmed.ncbi.nlm.nih.gov/
- **UpToDate**: https://www.uptodate.com/
- **CDC**: https://www.cdc.gov/
- **WHO**: https://www.who.int/

### Compliance
- **HIPAA**: https://www.hhs.gov/hipaa/
- **FDA**: https://www.fda.gov/

## 🤝 Contribuir

Ver [CONTRIBUTING.md](../../CONTRIBUTING.md) para guías de contribución.

## 📄 Licencia

Este proyecto es solo para fines educativos y de demostración. NO usar para diagnósticos médicos reales.

## ⚠️ Disclaimer Final

**Esta aplicación es un ejemplo educativo y NO debe usarse para decisiones médicas reales. Siempre consulte con profesionales de la salud calificados para cualquier pregunta o inquietud médica.**
