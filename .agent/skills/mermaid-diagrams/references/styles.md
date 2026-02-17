# Padrões Visuais Mermaid

Utilize estes estilos para garantir consistência visual na documentação do Open Finance Service.

## 🎨 Paleta de Cores (Hexagonal)
- **Domain (Core Logic)**: `#1f77b4` (Azul)
- **Application (Services/Ports)**: `#ff7f0e` (Laranja)
- **Adapters (In/Out)**: `#2ca02c` (Verde)
- **Infrastructure/External**: `#7f7f7f` (Cinza)

## 🛠️ Definição de Classes
Adicione estas definições ao final de seus diagramas:

```mermaid
classDef domain fill:#1f77b4,stroke:#333,stroke-width:2px,color:#fff
classDef application fill:#ff7f0e,stroke:#333,stroke-width:2px,color:#fff
classDef adapter fill:#2ca02c,stroke:#333,stroke-width:2px,color:#fff
classDef external fill:#7f7f7f,stroke:#333,stroke-width:2px,color:#fff
```

## 📐 Tipos de Diagrama Recomendados
- **Business Logic**: `flowchart TD`
- **API Interactions**: `sequenceDiagram`
- **Database Schema**: `erDiagram`
- **Architecture**: `graph LR` (com subgraphs para as camadas hexagonais)
