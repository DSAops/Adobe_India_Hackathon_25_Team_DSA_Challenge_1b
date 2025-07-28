# Adobe India Hackathon 2025 - Challenge 1B Architecture Diagram
## Team DSA: Persona-Driven Document Intelligence System

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                               INPUT LAYER                                                  │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│  📁 Collections/                                                                          │
│  ├── Collection 1/                                                                        │
│  │   ├── challenge1b_input.json  ← Persona + Job-to-be-Done + Document List              │
│  │   ├── PDFs/                   ← Document Collection (3-10 PDFs)                       │
│  │   │   ├── document1.pdf                                                                │
│  │   │   └── document2.pdf                                                                │
│  │   └── challenge1b_output.json ← Generated Results                                      │
│  └── Collection N/                                                                        │
└─────────────────────────────────────────────────────────────────────────────────────────┘
                                            │
                                            ▼
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                            ORCHESTRATION LAYER                                            │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                              📋 main.py                                                   │
│                      Collection Processor Engine                                          │
│                                                                                           │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐                          │
│  │  Auto-Discovery │  │  Validation     │  │ Batch Processing│                          │
│  │  Collections    │→ │  Structure      │→ │ Orchestration   │                          │
│  │  Scanner        │  │  Checker        │  │  Manager        │                          │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘
                                            │
                                            ▼
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                        DOCUMENT PROCESSING PIPELINE                                       │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                           │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐  │
│  │                    📄 text_extractor.py                                          │  │
│  │                Advanced OCR Text Extraction Engine                               │  │
│  │                                                                                   │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │   PDF to    │→ │   Table     │→ │ Multi-thread│→ │   Page-     │          │  │
│  │  │   Image     │  │  Detection  │  │ Processing  │  │  Aware Text │          │  │
│  │  │ Conversion  │  │ & Removal   │  │ (Parallel)  │  │ Extraction  │          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  │        │                │                │                │                   │  │
│  │    OpenCV +         Computer        ThreadPoolExecutor   Tesseract         │  │
│  │    PyMuPDF           Vision              +               OCR                │  │
│  │                   (Contour Det.)    Concurrent.futures                      │  │
│  └───────────────────────────────────────────────────────────────────────────────────┘  │
│                                            │                                              │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐  │
│  │                  🔍 heading_extractor.py                                         │  │
│  │               Document Structure Analysis Engine                              │  │
│  │                                                                                   │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │   Font      │→ │   Text      │→ │  Semantic   │→ │  Heading    │          │  │
│  │  │ Analysis    │  │ Filtering   │  │  Section    │  │  Level      │          │  │
│  │  │ (Size/Bold) │  │ & Cleanup   │  │ Grouping    │  │ Assignment  │          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  │        │                │                │                │                   │  │
│  │   PyMuPDF Dict     Regex Patterns   Content Analysis  Hierarchical         │  │
│  │   Text Blocks        + Keywords      + Position       Structure             │  │
│  └───────────────────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────────────────┘
                                            │
                                            ▼
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                         INTELLIGENCE & ANALYSIS LAYER                                     │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                           │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐  │
│  │                  🧠 persona_analyzer.py                                          │  │
│  │                  Persona Intelligence Engine                                    │  │
│  │                                                                                   │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │   Persona   │→ │    Task     │→ │   Domain    │→ │  Weighted   │          │  │
│  │  │  Analysis   │  │ Requirement │  │  Keyword    │  │  Keyword    │          │  │
│  │  │ (Role Map)  │  │ Extraction  │  │  Mapping    │  │  Scoring    │          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  │        │                │                │                │                   │  │
│  │  15+ Persona Types   NLP Action      Pre-built Domain   Dynamic Weight       │  │
│  │  (Travel, Research,   Verb Parsing   Libraries (15+)    Assignment           │  │
│  │   Business, etc.)                                                             │  │
│  └───────────────────────────────────────────────────────────────────────────────────┘  │
│                                            │                                              │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐  │
│  │                    ⚖️ relevance_scorer.py                                        │  │
│  │                Multi-Factor Relevance Scoring Engine                           │  │
│  │                                                                                   │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │  Keyword    │→ │   Title     │→ │  Position   │→ │   Final     │          │  │
│  │  │  Overlap    │  │ Relevance   │  │  Weighting  │  │  Composite  │          │  │
│  │  │ Score (40%) │  │Score (25%)  │  │Score (20%)  │  │Score (15%)  │          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  │        │                │                │                │                   │  │
│  │   TF-IDF Vector     Header Analysis   Early Section   Content Quality       │  │
│  │   Cosine Similarity   + Matching       Importance      Length + Structure    │  │
│  │   (sklearn)                                                                   │  │
│  └───────────────────────────────────────────────────────────────────────────────────┘  │
│                                            │                                              │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐  │
│  │                   ✂️ subsection_extractor.py                                    │  │
│  │              Content Refinement & Extraction Engine                          │  │
│  │                                                                                   │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │ Intelligent │→ │  Diversity  │→ │   Length    │→ │  Quality    │          │  │
│  │  │  Chunking   │  │  Filtering  │  │ Optimization│  │ Validation  │          │  │
│  │  │(Paragraph)  │  │(Anti-Redund)│  │(50-500 wds) │  │& Refinement │          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  │        │                │                │                │                   │  │
│  │  Sentence Boundary   Overlap Detection   Content Balance   Coherence         │  │
│  │  Awareness          + Deduplication    + Readability      Preservation       │  │
│  └───────────────────────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────────────────────┘
                                            │
                                            ▼
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                              OUTPUT GENERATION LAYER                                      │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│                                                                                           │
│  ┌───────────────────────────────────────────────────────────────────────────────────┐  │
│  │                        📊 JSON Output Generator                                  │  │
│  │                                                                                   │  │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │  │
│  │  │  Metadata   │→ │  Extracted  │→ │ Subsection  │→ │  Validation │          │  │
│  │  │ Assembly    │  │  Sections   │  │  Analysis   │  │ & Export    │          │  │
│  │  │(Docs+Persona│  │ (Ranked by  │  │ (Refined    │  │   (JSON)    │          │  │
│  │  │   +Task)    │  │ Importance) │  │   Text)     │  │             │          │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘          │  │
│  └───────────────────────────────────────────────────────────────────────────────────┘  │
│                                            │                                              │
│                                            ▼                                              │
│  📄 challenge1b_output.json                                                              │
│  {                                                                                        │
│    "metadata": { documents, persona, job_to_be_done, timestamp },                        │
│    "extracted_sections": [ { document, section_title, importance_rank, page_number } ],  │
│    "subsection_analysis": [ { document, refined_text, page_number } ]                    │
│  }                                                                                        │
└─────────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                              TECHNICAL CONSTRAINTS                                        │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│  🖥️  CPU-Only Processing    │  📏 Model Size ≤ 1GB    │  ⏱️  Processing ≤ 60s/5docs │
│  🚫 No Internet Access      │  💾 Memory ≤ 4GB        │  🔄 Multi-threaded Optimized  │
│  🐳 Docker Containerized    │  📦 Offline Operation    │  ⚡ scikit-learn + OpenCV    │
└─────────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                                 KEY INNOVATIONS                                           │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│  🎯 Adaptive Persona Mapping  │  ⚖️ Multi-Factor Scoring  │  🧠 Intelligence Engine     │
│  📊 Hybrid TF-IDF + Rules     │  🔄 Structure Preservation │  ✅ Quality Assurance       │
│  🎛️ Dynamic Weight Adjustment │  📈 Scalable Architecture  │  🛡️ Error Resilience        │
└─────────────────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                               PERFORMANCE METRICS                                         │
├─────────────────────────────────────────────────────────────────────────────────────────┤
│  📊 Section Relevance: 60 points (Multi-factor scoring + Domain keywords)               │
│  📝 Subsection Quality: 40 points (Granular analysis + Diversity enforcement)           │
│  ⚡ Processing Speed: <60s for 5 documents (Multi-threaded + optimized algorithms)       │
│  💾 Memory Efficiency: <4GB RAM usage (Streaming + garbage collection)                   │
│  🎯 Accuracy: Domain-specific libraries + Weighted persona matching                      │
└─────────────────────────────────────────────────────────────────────────────────────────┘
```

## Component Interaction Flow

### 1. **Input Processing**
```
Collections Directory → Auto-Discovery → Structure Validation → Input JSON Parsing
```

### 2. **Document Analysis Pipeline**
```
PDF Files → Text Extraction (OCR + Table Removal) → Heading Detection → Section Identification
```

### 3. **Intelligence Layer**
```
Persona Analysis → Keyword Mapping → Task Extraction → Relevance Scoring → Content Ranking
```

### 4. **Output Generation**
```
Section Ranking → Subsection Extraction → Content Refinement → JSON Assembly → File Export
```

## Architecture Highlights

### **Modularity**
- **Separation of Concerns**: Each component handles a specific aspect of processing
- **Plug-and-Play Design**: Components can be swapped or upgraded independently
- **Clear Interfaces**: Well-defined input/output contracts between modules

### **Scalability**
- **Batch Processing**: Handles multiple collections simultaneously
- **Multi-threading**: Parallel PDF page processing for performance
- **Memory Management**: Streaming and garbage collection for large documents

### **Reliability**
- **Error Handling**: Graceful degradation for corrupted files
- **Validation**: Structure and content validation at multiple stages
- **Fallback Mechanisms**: Alternative processing paths for edge cases

### **Extensibility**
- **Persona Libraries**: Easy addition of new persona types and keywords
- **Scoring Weights**: Configurable relevance scoring parameters
- **Output Formats**: Modular output generation for different requirements

This architecture ensures high-quality, persona-driven document analysis while maintaining performance and reliability within the specified constraints.
