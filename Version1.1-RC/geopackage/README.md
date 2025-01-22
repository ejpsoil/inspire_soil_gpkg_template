# INSPIRE SO GeoPackage Resources  

This repository provides resources for working with the **INSPIRE Soil (SO)** data model in GeoPackage format. Below is an overview of the folder structure and their respective contents.  

## Folder Structure  

### 1. `INSPIRE_SO_empty`  
- **Contents:**  
  - A GeoPackage file containing the complete INSPIRE SO data structure.  
- **Purpose:**  
  - To provide a clean template of the INSPIRE SO model for further customization and data population.  

---

### 2. `INSPIRE_SO_empty_and_QGIS_project`  
- **Contents:**  
  - A GeoPackage file with the complete INSPIRE SO structure.  
  - A set of QGIS forms designed to assist users in:  
    - Navigating the GeoPackage content.  
    - Entering and managing data.  
- **Usage Instructions:**  
  1. Link the GeoPackage to QGIS.  
  2. Open the **`SO_PRJ`** project file (contained within the GeoPackage).  
  3. Use the provided forms for data management.  

---

### 3. `INSPIRE_SO_with_data`  
- **Contents:**  
  - A GeoPackage file with:  
    - The complete INSPIRE SO structure.  
    - Sample data derived from the **Soil Map of Sicily** (scale 1:250,000) (Fantappiè et al., 2011).  
- **Purpose:**  
  - To serve as an example dataset for testing and demonstration purposes.  

---

### 4. `INSPIRE_SO_with_data_and_QGIS_project`  
- **Contents:**  
  - A GeoPackage file with:  
    - The complete INSPIRE SO structure.  
    - Sample data derived from the **Soil Map of Sicily** (scale 1:250,000) (Fantappiè et al., 2011).  
    - A set of QGIS forms for:  
      - Easier navigation of the dataset.  
      - Data input and editing.  
- **Usage Instructions:**  
  1. Link the GeoPackage to QGIS.  
  2. Open the **`SO_PRJ`** project file (contained within the GeoPackage).  
  3. Utilize the included forms for efficient data handling.  

---

### 5. `DB_Schema`  
- **Contents:**  
  - A PNG file containing the database schema for the INSPIRE SO GeoPackage.  
- **Purpose:**  
  - To provide a visual representation of the database structure, helping users understand the relationships between tables and fields.  

---

## Key Features  
- **INSPIRE Compliance:**  
  The GeoPackage files are designed to conform to the INSPIRE Soil data model, ensuring compatibility with EU standards.  
- **Ease of Use:**  
  Pre-configured QGIS forms and project files simplify data management, visualization, and editing.  
- **Sample Data:**  
  Example datasets provide a practical demonstration of how to use the INSPIRE SO model effectively.  
- **Database Schema:**  
  The schema diagram in `DB_Schema.png` visually explains the structure of the database.  

---

Feel free to explore the contents of this repository and use these resources to streamline your soil data management workflows.  

---

**-- QGIS version 3.32.3-Lima or higher is required. --**

---

## References

Fantappiè, M., Bocci, M., Paolanti, M., Perciabosco, M., Antinoro, C., Riveccio, R., et al. (2011).  
**Realizzazione della carta digitale dei suoli della Sicilia utilizzando il rilevamento GIS-oriented e un modello CLORPT.**  
In *La percezione del suolo* (pp. 139-142). Le Penseur.  
[Online version available here](https://iris.unipa.it/handle/10447/105053?mode=full).
