# Adobe India Hackathon 2025 - Round 1B Solution
## Team DSA Challenge - Persona-Driven Document Intelligence

### 🎯 **Challenge Overview**
This solution addresses Round 1B: "Connect What Matters — For the User Who Matters" challenge, implementing an intelligent document analyst that extracts and prioritizes the most relevant sections from PDF collections based on specific personas and their job-to-be-done requirements.

---

## 📋 **Table of Contents**
1. [Problem Statement](#problem-statement)
2. [Solution Architecture](#solution-architecture)
3. [Installation & Usage](#installation--usage)
4. [File Structure](#file-structure)
5. [Input/Output Format](#inputoutput-format)
6. [Performance Specifications](#performance-specifications)
7. [Docker Deployment](#docker-deployment)

---

## 🎯 **Problem Statement**

**Input:** 
- Document Collection: 3-10 related PDFs
- Persona Definition: Role description with specific expertise areas
- Job-to-be-Done: Concrete task the persona needs to accomplish

**Output:** JSON structure containing:
- Metadata (documents, persona, task, timestamp)
- Extracted sections ranked by importance
- Refined subsection analysis with relevant text

**Constraints:**
- CPU-only processing
- Model size ≤ 1GB
- Processing time ≤ 60 seconds
- No internet access during execution

---

## 🏗️ **Solution Architecture**

### **Core Components**

1. **Text Extractor** (`text_extractor.py`)
   - Advanced OCR with table detection/removal
   - Multi-threaded page processing
   - Page-aware text extraction

2. **Section Extractor** (`section_extractor.py`)
   - Font-based heading detection
   - Semantic section identification
   - Document structure preservation

3. **Persona Analyzer** (`persona_analyzer.py`)
   - Domain-specific keyword mapping
   - Task requirement extraction
   - Weighted relevance scoring

4. **Relevance Scorer** (`relevance_scorer.py`)
   - Multi-factor section scoring
   - TF-IDF similarity calculation
   - Position and quality weighting

5. **Subsection Extractor** (`subsection_extractor.py`)
   - Paragraph-level content extraction
   - Relevance-based filtering
   - Text refinement and optimization

6. **Collection Processor** (`main.py`)
   - Auto-discovery of collections
   - Batch processing orchestration
   - Output generation and validation

---

## 🚀 **Installation & Usage**

### **Setup Options**

#### **Option 1: Docker (Recommended)**
```bash
# Build the Docker image
docker build --platform linux/amd64 -t adobe-challenge-1b:teamDSA .


# put the sample collections into the Collection folder (check Troubleshooting if you face any issue)

# Run the container with volume mounts
docker run --rm \
  -v $(pwd)/Collections:/app/Collections \
  --network none \
  adobe-challenge-1b:teamDSA


# review the output.json files
```

#### **Option 2: Local Setup**
```bash
# Install Python dependencies
pip install -r requirements.txt

# Install system dependencies (Ubuntu/Debian)
sudo apt-get install tesseract-ocr tesseract-ocr-eng

# Run the application
python3 main.py
```

---

## 📁 **File Structure**

```
Adobe_India_Hackathon_25_Team_DSA_Challenge_1b/
├── main.py                     # Main collection processor
├── text_extractor.py           # PDF text extraction with OCR
├── heading_extractor.py        # Document heading detection
├── persona_analyzer.py         # Persona and task analysis
├── relevance_scorer.py         # Multi-factor relevance scoring
├── subsection_extractor.py     # Subsection extraction and refinement
├── requirements.txt            # Python dependencies
├── Dockerfile                  # Container configuration
├── docker-compose.yml          # Multi-container setup
├── README.md                   # This file
├── approach_explanation.md     # Detailed methodology documentation
└── Collections/                # Collections folder
    └── Collection N/           # Individual collection folders
        ├── challenge1b_input.json  # Input specification (REQUIRED NAME)
        ├── PDFs/               # Source documents folder
        │   ├── document1.pdf
        │   └── document2.pdf
        └── challenge1b_output.json # Generated results
```

**⚠️ Important File Naming:**
- Input file MUST be named: `challenge1b_input.json`
- PDFs should be placed in a `PDFs/` or `PDFs` folder
- Output will be generated as: `challenge1b_output.json`

---

## 📝 **Input/Output Format**

### **Input Structure** (`challenge1b_input.json`)
```json
{
    "challenge_info": {
        "challenge_id": "round_1b_002",
        "test_case_name": "travel_planner",
        "description": "France Travel"
    },
    "documents": [
        {
            "filename": "South of France - Cities.pdf",
            "title": "South of France - Cities"
        }
    ],
    "persona": {
        "role": "Travel Planner"
    },
    "job_to_be_done": {
        "task": "Plan a trip of 4 days for a group of 10 college friends."
    }
}
```

### **Output Structure** (`challenge1b_output.json`)
```json
{
    "metadata": {
        "input_documents": ["document1.pdf", "document2.pdf"],
        "persona": "Travel Planner",
        "job_to_be_done": "Plan a trip of 4 days for a group of 10 college friends.",
        "processing_timestamp": "2025-07-10T15:31:22.632389"
    },
    "extracted_sections": [
        {
            "document": "document1.pdf",
            "section_title": "Section Title",
            "importance_rank": 1,
            "page_number": 1
        }
    ],
    "subsection_analysis": [
        {
            "document": "document1.pdf",
            "refined_text": "Extracted and refined text content...",
            "page_number": 1
        }
    ]
}
```

---

## ⚡ **Performance Specifications**

### **Processing Capabilities**
- **Document Capacity**: 3-10 PDFs per collection
- **Page Limit**: Up to 50 pages per document
- **File Size**: Supports up to 100MB PDFs
- **Collection Processing**: Unlimited collections

### **Performance Metrics**
- **Processing Speed**: <60 seconds for 5 documents
- **Memory Usage**: <4GB RAM
- **Model Size**: <1GB total footprint
- **CPU Utilization**: Multi-threaded optimization

### **Quality Assurance**
- **Section Relevance**: Multi-factor scoring algorithm
- **Subsection Quality**: Semantic coherence preservation
- **Output Consistency**: Standardized JSON format
- **Error Handling**: Graceful degradation for corrupted files

---

## 🐳 **Docker Deployment**

### **Container Specifications**


## 🔧 **Troubleshooting**

### **Common Issues**

#### **File Naming Errors**
```
❌ Error: "Input file found but with incorrect name: 'challenge1b_input .json'"
✅ Solution: Rename file to 'challenge1b_input.json' (remove extra space)

❌ Error: "No input.json file found. Required name: 'challenge1b_input.json'"
✅ Solution: Ensure input file is named exactly 'challenge1b_input.json'
```

#### **Folder Structure Issues**
```
❌ Error: "No PDF/PDFs folder found"
✅ Solution: Create 'PDFs' folder and place all PDF files inside it

❌ Error: "No collections found!"
✅ Solution: Ensure collections are in 'Collections' folder or named 'Collection X'
```

#### **Docker Issues**
```bash
# Fix permission issues
sudo chmod -R 755 Collections/

# Rebuild if dependencies changed
docker build --no-cache -t adobe-challenge-1b:teamDSA .
```

---

## 🔧 **Configuration & Customization**

### **Persona Extension**
Add new personas in `persona_analyzer.py`:
```python
"new_persona": ["keyword1", "keyword2", "domain_terms"]
```

### **Relevance Tuning**
Adjust scoring weights in `relevance_scorer.py`:
```python
total_score = (
    keyword_score * 0.4 +     # Keyword matching weight
    title_score * 0.25 +      # Title relevance weight
    position_score * 0.2 +    # Position importance weight
    length_score * 0.15       # Content quality weight
)
```

### **Output Customization**
Modify output format in `main.py` collection processor.

---

## 📊 **Testing & Validation**

### **Test Collections**
The system includes sample collections for validation:
- Travel planning scenario
- Academic research context
- Business analysis use case

### **Validation Metrics**
- Section relevance accuracy
- Subsection quality assessment
- Processing time compliance
- Memory usage monitoring

---

## 🤝 **Team Information**

**Team:** DSA (Devraj, Saksham, and Anuj)  
**Challenge:** Round 1B - Persona-Driven Document Intelligence  
**Theme:** "Connect What Matters — For the User Who Matters"

**Key Features:**
- ✅ Multi-persona support
- ✅ Intelligent section ranking with multi-factor scoring
- ✅ Advanced OCR with table detection
- ✅ Subsection extraction and refinement
- ✅ Docker containerization for reproducible deployment
- ✅ CPU-only processing for broad compatibility
- ✅ Offline operation with pre-packaged models

---

## 📄 **License & Usage**

This solution is developed for the Adobe India Hackathon 2025. All code and documentation are provided for evaluation purposes.

For questions or technical support, please refer to the approach_explanation.md for detailed methodology information.