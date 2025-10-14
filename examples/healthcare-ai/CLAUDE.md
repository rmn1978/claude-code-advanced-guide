# Healthcare AI Application

## 🎯 Project Overview

Medical diagnostic support system using AI-powered symptom analysis, differential diagnosis generation, and FHIR integration.

**⚠️ IMPORTANT**: This is an educational/demonstration project. NOT for real medical use.

## 🏗️ Technology Stack

### Backend
- **Runtime**: Node.js 20 LTS
- **Framework**: Express.js 4.x
- **Language**: TypeScript 5.x (strict mode)
- **Database**: PostgreSQL 15
- **ORM**: Prisma 5.x

### Frontend
- **Framework**: React 18 + TypeScript
- **Build**: Vite
- **Styling**: Tailwind CSS
- **State**: Zustand
- **Forms**: React Hook Form + Zod

### Medical Standards
- **FHIR**: R4 (4.0.1)
- **ICD-10**: 2024 version
- **SNOMED CT**: International edition

### Security & Compliance
- **HIPAA**: Compliant logging and encryption
- **Authentication**: JWT + Refresh tokens
- **Encryption**: AES-256-GCM for PHI

## 📁 Project Structure

```
healthcare-ai/
├── src/
│   ├── api/
│   │   ├── patients/           # Patient management endpoints
│   │   ├── diagnostics/        # Symptom analysis endpoints
│   │   ├── prescriptions/      # Medication management
│   │   └── fhir/               # FHIR resources endpoints
│   ├── services/
│   │   ├── symptom-analyzer.ts      # Core symptom analysis
│   │   ├── diagnosis-generator.ts   # Differential diagnosis
│   │   ├── fhir-service.ts          # FHIR conversions
│   │   ├── icd10-mapper.ts          # ICD-10 coding
│   │   └── drug-interaction.ts      # Drug interaction checks
│   ├── models/
│   │   ├── patient.model.ts
│   │   ├── symptom.model.ts
│   │   ├── diagnosis.model.ts
│   │   └── medication.model.ts
│   ├── utils/
│   │   ├── medical-nlp.ts           # Medical NLP utilities
│   │   ├── hipaa-logger.ts          # HIPAA-compliant logging
│   │   └── encryption.ts            # PHI encryption
│   └── validators/
│       ├── patient.validator.ts
│       └── symptom.validator.ts
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── prisma/
│   ├── schema.prisma
│   └── migrations/
└── docs/
    ├── api/
    └── medical/
```

## 🎨 Coding Conventions

### TypeScript Standards

#### Type Safety
```typescript
// ✅ ALWAYS use explicit types
function analyzeSymptoms(symptoms: Symptom[]): Promise<DiagnosisResult> {
  // ...
}

// ❌ NEVER use implicit any
function analyzeSymptoms(symptoms) {  // Bad!
  // ...
}

// ✅ Use strict null checks
interface Patient {
  email: string | null;  // Explicitly nullable
  phone?: string;        // Optional
}

// ❌ Avoid optional when null is more appropriate
interface Patient {
  email?: string;  // Unclear: missing or null?
}
```

#### Naming Conventions

**Variables & Functions**: camelCase
```typescript
const patientRecord = getPatientById(id);
function calculateRiskScore(factors: RiskFactor[]): number {}
```

**Interfaces & Types**: PascalCase
```typescript
interface PatientRecord {}
type DiagnosisResult = {};
```

**Constants**: UPPER_SNAKE_CASE
```typescript
const MAX_SYMPTOMS_PER_ANALYSIS = 20;
const DEFAULT_SEVERITY_THRESHOLD = 5;
```

**Files**: kebab-case
```typescript
// patient-service.ts
// symptom-analyzer.ts
// drug-interaction-checker.ts
```

#### Interfaces vs Types

```typescript
// ✅ Use `interface` for object shapes (can be extended)
interface Patient {
  id: string;
  name: string;
}

interface DetailedPatient extends Patient {
  medicalHistory: MedicalHistory;
}

// ✅ Use `type` for unions, intersections, and complex types
type DiagnosisProbability = 'high' | 'moderate' | 'low';
type Result<T> = { success: true; data: T } | { success: false; error: string };
```

### API Design

#### Endpoint Structure
```
/api/v1/patients                # List all patients
/api/v1/patients/:id            # Get specific patient
/api/v1/patients/:id/symptoms   # Nested resource

/api/v1/diagnostics/analyze     # Action-based endpoint
/api/v1/fhir/Patient/:id        # FHIR endpoints (capital resource)
```

#### HTTP Methods
- `GET`: Retrieve (safe, idempotent)
- `POST`: Create or complex operations
- `PUT`: Full update (idempotent)
- `PATCH`: Partial update
- `DELETE`: Remove (idempotent)

#### Response Format

**Success (200, 201)**:
```json
{
  "data": {
    "id": "patient-123",
    "name": "John Doe"
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z",
    "version": "1.0"
  }
}
```

**Error (4xx, 5xx)**:
```json
{
  "error": {
    "code": "RESOURCE_NOT_FOUND",
    "message": "Patient with ID 'patient-123' not found",
    "details": {
      "requestedId": "patient-123",
      "resource": "Patient"
    }
  },
  "meta": {
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

#### Error Codes

Standard error codes used in this project:

| Code | HTTP | Meaning |
|------|------|---------|
| `VALIDATION_ERROR` | 400 | Invalid input data |
| `UNAUTHORIZED` | 401 | Not authenticated |
| `FORBIDDEN` | 403 | Not authorized for resource |
| `RESOURCE_NOT_FOUND` | 404 | Resource doesn't exist |
| `DUPLICATE_RESOURCE` | 409 | Resource already exists |
| `INTERNAL_ERROR` | 500 | Server error |

### Database Schema

#### Naming Conventions

**Tables**: Plural, snake_case
```sql
patients
medical_conditions
prescription_medications
```

**Columns**: snake_case
```sql
first_name
date_of_birth
created_at
```

**Foreign Keys**: `{table_singular}_id`
```sql
patient_id
prescription_id
```

**Indexes**: `idx_{table}_{columns}`
```sql
idx_patients_email
idx_conditions_patient_id_active
```

**Constraints**: `{table}_{column}_{type}`
```sql
patients_email_unique
conditions_severity_check
```

#### Standard Columns

Every table should have:
```sql
id UUID PRIMARY KEY DEFAULT gen_random_uuid()
created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
deleted_at TIMESTAMP WITH TIME ZONE  -- Soft delete
```

#### Example Schema
```prisma
model Patient {
  id        String   @id @default(uuid())
  mrn       String   @unique  // Medical Record Number

  firstName String   @map("first_name")
  lastName  String   @map("last_name")
  email     String?  @unique

  dateOfBirth DateTime @map("date_of_birth")
  gender      Gender

  conditions    Condition[]
  medications   Medication[]

  createdAt DateTime  @default(now()) @map("created_at")
  updatedAt DateTime  @updatedAt @map("updated_at")
  deletedAt DateTime? @map("deleted_at")

  @@map("patients")
}

enum Gender {
  MALE
  FEMALE
  OTHER
  UNKNOWN
}
```

## 🔒 Security & Compliance

### HIPAA Compliance

#### Protected Health Information (PHI)

**PHI includes**:
- Names
- Dates (birth, admission, discharge, death)
- Phone/fax numbers
- Email addresses
- Social Security numbers
- Medical record numbers
- Account numbers
- Biometric identifiers
- Full-face photos
- Any unique identifying characteristic

#### Logging Rules

```typescript
// ✅ SAFE - Log IDs and actions
logger.info('Patient record accessed', {
  userId: 'user-123',
  patientId: 'patient-456',
  action: 'view',
  timestamp: new Date()
});

// ❌ UNSAFE - Contains PHI
logger.info('John Doe accessed');  // Name is PHI
logger.info('Patient SSN: 123-45-6789');  // SSN is PHI
logger.debug('Email: patient@example.com');  // Email is PHI
```

#### Encryption

All PHI must be encrypted:

```typescript
// Encrypt before storing
const encrypted = encrypt(patient.ssn);
await db.patient.update({
  where: { id },
  data: { ssnEncrypted: encrypted }
});

// Decrypt when needed
const ssn = decrypt(patient.ssnEncrypted);
```

#### Audit Logging

All PHI access must be logged:

```typescript
await auditLog.create({
  userId: req.user.id,
  action: 'PATIENT_VIEW',
  resourceType: 'Patient',
  resourceId: patientId,
  ipAddress: req.ip,
  timestamp: new Date()
});
```

### Authentication & Authorization

#### JWT Structure
```typescript
{
  sub: 'user-123',           // User ID
  role: 'physician',          // User role
  permissions: ['read:patients', 'write:diagnoses'],
  iat: 1705312800,
  exp: 1705316400            // 1 hour expiration
}
```

#### Authorization Matrix

| Role | Patients | Diagnoses | Prescriptions | Admin |
|------|----------|-----------|---------------|-------|
| Physician | RWD | RWD | RW | - |
| Nurse | RW | R | R | - |
| Admin Staff | RW | - | - | - |
| System Admin | R | R | R | RWD |

(R=Read, W=Write, D=Delete)

## 🧪 Testing Standards

### Coverage Requirements

- **Unit Tests**: 80% minimum
- **Integration Tests**: 70% minimum
- **E2E Tests**: Critical paths only

### Test Structure

```typescript
describe('SymptomAnalyzer', () => {
  // Setup
  beforeEach(() => {
    // Fresh instance for each test
  });

  // Group related tests
  describe('analyze()', () => {
    it('should identify high-risk symptoms', async () => {
      // Arrange
      const symptoms = [...];

      // Act
      const result = await analyzer.analyze(symptoms);

      // Assert
      expect(result.redFlags).toHaveLength(1);
    });

    it('should generate ICD-10 codes', async () => {
      // ...
    });
  });

  describe('edge cases', () => {
    it('should handle empty symptom list', async () => {
      // ...
    });
  });
});
```

### Test Naming

```typescript
// ✅ Descriptive: what it tests and expected behavior
it('should return 404 when patient does not exist')
it('should encrypt SSN before saving to database')
it('should identify drug interactions for warfarin and aspirin')

// ❌ Vague
it('works')
it('test patient')
```

### Mocking External Services

```typescript
// Mock FHIR server
jest.mock('@/services/fhir-service', () => ({
  createPatient: jest.fn().mockResolvedValue({
    id: 'Patient/123',
    resourceType: 'Patient'
  })
}));

// Mock drug interaction API
jest.mock('@/services/drug-interaction', () => ({
  checkInteractions: jest.fn().mockResolvedValue([])
}));
```

## 🚀 Development Workflow

### Branch Strategy

```
main                    # Production
  ↓
develop                 # Integration
  ↓
feature/symptom-analysis    # Features
fix/diagnosis-bug          # Bug fixes
hotfix/security-patch      # Urgent production fixes
```

### Commit Messages

Use Conventional Commits:

```bash
# Format
<type>(<scope>): <subject>

# Examples
feat(diagnostics): add drug interaction checking
fix(patients): resolve HIPAA logging issue
docs(api): update FHIR endpoint documentation
test(symptoms): add unit tests for analyzer
refactor(database): optimize patient query performance
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Tests
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `chore`: Maintenance

### Pull Request Process

1. Create feature branch from `develop`
2. Implement feature with tests
3. Run full test suite: `npm test`
4. Run linter: `npm run lint`
5. Create PR with description
6. Request review (minimum 1 reviewer)
7. Address feedback
8. Merge to `develop` (squash merge)

### PR Template

```markdown
## Description
[Describe what this PR does]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Medical Safety Review
- [ ] No changes to diagnostic algorithms, OR
- [ ] Diagnostic changes reviewed by medical expert
- [ ] HIPAA compliance verified

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] All tests passing
- [ ] Manual testing completed

## Security
- [ ] No new PHI exposure
- [ ] Encryption properly implemented
- [ ] Audit logging added where needed

## Checklist
- [ ] Code follows project conventions
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
```

## 🛠️ Common Commands

```bash
# Development
npm run dev              # Start dev server (both frontend and backend)
npm run dev:backend      # Backend only
npm run dev:frontend     # Frontend only

# Database
npm run db:migrate       # Run migrations
npm run db:reset         # Reset database (DEV ONLY!)
npm run db:seed          # Seed with test data
npx prisma studio        # Open Prisma Studio

# Testing
npm test                 # Run all tests
npm run test:watch       # Watch mode
npm run test:coverage    # With coverage report
npm run test:unit        # Unit tests only
npm run test:integration # Integration tests only
npm run test:e2e         # E2E tests only

# Code Quality
npm run lint             # Run ESLint
npm run lint:fix         # Auto-fix issues
npm run format           # Run Prettier
npm run type-check       # TypeScript check

# Build
npm run build            # Production build
npm run preview          # Preview production build

# Docker
docker-compose up        # Start all services
docker-compose down      # Stop all services
docker-compose logs -f   # View logs
```

## 📚 Medical Knowledge Bases

### Reference Materials

When implementing medical features, consult:

1. **Clinical Guidelines**
   - UpToDate: https://www.uptodate.com/
   - CDC: https://www.cdc.gov/
   - WHO: https://www.who.int/

2. **Medical Standards**
   - FHIR R4: https://www.hl7.org/fhir/
   - ICD-10: https://www.who.int/classifications/icd/
   - SNOMED CT: https://www.snomed.org/

3. **Drug Information**
   - DrugBank: https://go.drugbank.com/
   - FDA: https://www.fda.gov/

### Terminology

**Key medical abbreviations used in code**:

| Term | Meaning |
|------|---------|
| PHI | Protected Health Information |
| MRN | Medical Record Number |
| ICD | International Classification of Diseases |
| SNOMED | Systematized Nomenclature of Medicine |
| FHIR | Fast Healthcare Interoperability Resources |
| ACS | Acute Coronary Syndrome |
| SOB | Shortness of Breath |
| HPI | History of Present Illness |
| PMH | Past Medical History |

## 🎯 Agent Usage Patterns

### When to Use Medical Diagnostic Agent

```typescript
// User asks to analyze symptoms
> Analyze these symptoms: fever, cough, chest pain

// Agent invocation
> Use the medical-diagnostic agent to evaluate this patient presentation

// Expected: Full differential diagnosis with ICD-10 codes
```

### When to Use FHIR Specialist

```typescript
// Converting data to FHIR format
> Convert this patient data to FHIR Bundle

// Validating FHIR resources
> Validate this FHIR Patient resource for compliance

// Expected: Properly formatted FHIR JSON
```

### When to Use Drug Interaction Checker

```typescript
// Checking prescriptions
> Check interactions: Warfarin, Aspirin, Metformin

// Adding new medication
> Patient on Warfarin wants to start Ibuprofen, check interactions

// Expected: Interaction report with severity and recommendations
```

## 🐛 Known Issues & Workarounds

### Issue: FHIR Validation Errors

**Problem**: FHIR validator sometimes rejects valid resources

**Workaround**: Ensure timezone in dates: `2024-01-15T10:30:00Z` (note the Z)

### Issue: Drug Interaction Database Lag

**Problem**: Drug interaction database may be outdated

**Workaround**: Always cross-reference with current FDA alerts and package inserts

## 📋 Pre-flight Checklist

Before deploying to production:

- [ ] All tests passing (unit, integration, e2e)
- [ ] HIPAA compliance verified
- [ ] Encryption enabled for all PHI
- [ ] Audit logging functional
- [ ] Medical disclaimers present
- [ ] No hardcoded credentials
- [ ] Environment variables configured
- [ ] Database migrations tested
- [ ] Backup strategy in place
- [ ] Monitoring and alerting configured
- [ ] Medical expert review (for diagnostic changes)

## 👥 Team & Responsibilities

- **Tech Lead**: Architecture, code review
- **Backend Team**: API, database, business logic
- **Frontend Team**: UI/UX, client-side logic
- **Medical Advisor**: Clinical accuracy, safety review
- **Security Team**: HIPAA compliance, security audit
- **QA**: Testing, quality assurance

## 📞 Emergency Contacts

**Security Issue**: security@example.com
**HIPAA Breach**: hipaa-officer@example.com
**On-call Engineering**: +1-555-0100

## 🎓 Onboarding Resources

New team members should:
1. Read this CLAUDE.md thoroughly
2. Review HIPAA training materials
3. Study FHIR R4 specification basics
4. Run through test patient scenarios
5. Pair program with experienced team member

## 💡 Tips for Claude Code Users

When working with Claude Code on this project:

1. **Always mention medical context** so the medical-diagnostic agent is invoked
2. **Use project commands** like `/project:analyze-symptoms` for common tasks
3. **Request FHIR validation** when creating/modifying FHIR resources
4. **Ask for HIPAA review** when handling patient data
5. **Cite medical sources** by asking "what guidelines support this?"

---

**Remember**: This is a demonstration project. Never use for real medical decisions. Always consult qualified healthcare professionals.
