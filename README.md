# Illuminating the functional landscape of the dark proteome across the Animal Tree of Life through natural language processing models

[![License](https://img.shields.io/badge/license-GPLv3-blue.svg)](http://www.gnu.org/licenses/gpl.html)

This repository contains all the scripts generated and used for this project. For the pipeline to functionally annotate any given proteome file, check [FANTASIA](https://github.com/MetazoaPhylogenomicsLab/FANTASIA).

**Authors**: Gemma I. Martínez-Redondo<sup>1</sup>, Israel Barrios-Núñez<sup>2</sup>, Marçal Vázquez-Valls<sup>1</sup>, Ana M. Rojas<sup>2</sup>, Rosa Fernández<sup>1</sup>

<sup>1</sup> Metazoa Phylogenomics Lab, Biodiversity Program, Institute of Evolutionary Biology (CSIC-Universitat Pompeu Fabra), Passeig Marítim de la Barceloneta 37-49, 08003 Barcelona, Spain

<sup>2</sup> Computational Biology and Bioinformatics, Andalusian Center for Developmental Biology (CABD-CSIC), 41013 Sevilla, Spain.

***
## Content of this Github

Files:

- **README.md**

Folders:

- **Scripts**: Scripts used for data processing, analyses and plotting. See explanation below.
Subfolders:
  - **data_processing**: scripts used for data preprocessing.
  - **disorder**: scripts used for calculating per-protein disorder.
  - **go_enrichment**:  scripts used for preparing files for GO enrichment.
  - **gos_per_gene**: scripts used to obtain number of GO terms per gene.
  - **IC_for_plots**: scripts used for processing files with Information Content (IC) for plotting.
  - **Isoforms**: scripts for analyses comparing longest and all isoforms.
  - **model_organisms**: scripts for all model organisms analyses.
  - **Semantic_similarity**: scripts for calculating semantic similarity.
  - **taxonomy_lookup**: scripts for obtaining the taxonomical origin of the proteins in the lookup database of GOPredSim.
- **Figures**:  figure files and scripts to generate them together with some analyses (like GO enrichment).

***
**Citation**: Martínez-Redondo, G. I. ([gemma.martinez@ibe.upf-csic.es](mailto:gemma.martinez@ibe.upf-csic.es)), Barrios-Núñez, I., Vázquez-Valls, M., Rojas, A. M. ([a.rojas.m@csic.es](mailto:a.rojas.m@csic.es)), & Fernández, R. ([rosa.fernandez@ibe.upf-csic.es](mailto:rosa.fernandez@ibe.upf-csic.es)). (2024). Illuminating the functional landscape of the dark proteome across the Animal Tree of Life. [https://doi.org/10.1101/2024.02.28.582465](https://doi.org/10.1101/2024.02.28.582465).

For our work about the performance of the different methods in model organisms check: Barrios-Núñez, I., Martínez-Redondo, G. I., Medina-Burgos, P., Cases, I., Fernández, R. ([rosa.fernandez@ibe.upf-csic.es](mailto:rosa.fernandez@ibe.upf-csic.es)) & Rojas, A.M. ([a.rojas.m@csic.es](mailto:a.rojas.m@csic.es)). (2024). Decoding proteome functional information in model organisms using protein language models. [https://doi.org/10.1101/2024.02.14.580341](https://doi.org/10.1101/2024.02.14.580341)

***
## Data availability (Zenodo).
Only initial and final result files are included. Several intermediate files that take several gigabytes of spaces have not been added but steps followed to obtain them are located below.
<details>
<summary><b><a href="https://doi.org/10.5281/zenodo.10714961">Part 1</a></b></summary>
</br>
Part 1 contains:

	- longest_isoforms_gopredsim_seqvec_A_to_E.tar.gz : GOPredSim GO annotation using SeqVec model for the longest isoform or species whose code first letter goes from A to E.
	
	- longest_isoforms_deepgoplus.tar.gz : DeepGOPlus GO annotation for the longest isoform of all species.
	
	- all_isoforms_deepgoplus.tar.gz : DeepGOPlus GO annotation for all isoforms for a subset of 102 species.
	
	- all_isoforms_eggnog_filtered_goterms.tar.gz : eggNOG-mapper functional annotation for all isoforms for a subset of 102 species.
	
	- annotated_genes_eggnog.txt : list of genes that have a GO term annotation from eggNOG-mapper.
	
	- go_per_gene_filters_stats_go_cat_subset.tar.gz : number of GO terms per gene for all filters applied and all functional annotation methods for a subset of 102 species.
	
	- semsim_longest_eggnog_seqvec_go_category.tar.gz : semantic similarity separated by GO category between the GO annotations from eggNOG-mapper and GOPredSim (SeqVec model) for the longest isoform of a subset of 102 species.
	
	- semsim_longest_eggnog_prott5_go_category.tar.gz : semantic similarity separated by GO category between the GO annotations from eggNOG-mapper and GOPredSim (ProtT5 model) for the longest isoform of a subset of 102 species.
	
	- semsim_longest_eggnog_deepgoplus_go_category.tar.gz : semantic similarity separated by GO category between the GO annotations from eggNOG-mapper and DeepGOPlus for the longest isoform of a subset of 102 species.
	
	- isoforms_stats.tar.gz : number of genes with functional annotation when using all isoforms or just the longest of a subset of 102 species for all methods used.
	
	- semsim_allvslong_go_cat.txt : semantic similarity separated by GO category between the GO annotations when using all isoforms or just the longest of a subset of 102 species.
	
	- taxonomy_lookup_dataset.tar.gz : Uniprot taxonomy information used for obtaining the taxonomic origin of the proteins in the lookup dataset and results.
	
	- CSCU1_unannotated_toxins.txt : list of proteins from *Centruroides sculpturatus* predicted to have toxin activity but not being annotated by eggNOG-mapper.
	
	- ToxinPred2_0_output_CSCU_putative_toxins.pdf : ToxinPred2 output for the prediction of toxin activity of the proteins in the CSCU1_unannotated_toxins.txt file.
	
	- CSCU1_DN0_c0_g23215_i1p1_20900.result.zip :ColabFold predicted protein structure of a previously unannotated putative tachylectin-5 homolog in *C. sculpturatus*.
	
	- structures_2024-2-19-14-15-54.zip : PDB pairwise structure alignment result for *C. sculpturatus* new and previously identified tachylectin-5 with *Tachypleus tridentatus* tachylectin-5A (PDB 1JC9).
	
	- XP_023224331_3bbdb.result.zip : ColabFold predicted protein structure of previously tachylectin-5-like XP_023224331 protein in *C. sculpturatus*.
	
	- CG11373_92f17.result.zip : ColabFold predicted protein structure of CG11373 in *Drosophila melanogaster*.
	
	- all_species_topgo_input.tar.gz : topGO input GOPredSim-ProtT5 GO annotations for all species.
	
	- GO_enrichment_results_per_phylum.tar.gz : per-phylum combined results of per-species GO enrichment results.
	
	- GO_enrichment_results_per_species.tar.gz : GO enrichment of GO terms of genes not annotated by eggNOG-mapper for all species.
	
	- cluster_unassigned_agr.txt : manual assignment of GO cluster representatives that could not be assigned to a Alliance for Genomics Resources (AGR) GO Slim GO category.
	
	- cluster_unassigned_agr_not_sure.txt : explanation of the manual assignment of GO cluster representatives that could not be assigned to a AGR GO Slim GO category.
	
	- common_GOs_BP_all_phyla.txt : Biological process (BP) GO terms that were commonly enriched in all animal phyla.
	
	- common_GOs_CC_all_phyla.txt : Cellular component (CC) GO terms that were commonly enriched in all animal phyla.
	
	- common_GOs_MF_all_phyla.txt : Molecular function (MF) GO terms that were commonly enriched in all animal phyla.
	
	- GO_clusters_comparison_per_phylum.txt : number of clusters predicted by several clustering methods for each GO category for each of the animal phyla.
	
	- GOslim_agr_unassigned_GOs_clustersBP.txt : GO cluster representatives of clustered BP GO terms that could not be assigned to a Alliance for Genomics Resources (AGR) GO Slim GO category.
	
	- GOslim_agr_unassigned_GOs_clustersCC.txt : GO cluster representatives of clustered CC GO terms that could not be assigned to a Alliance for Genomics Resources (AGR) GO Slim GO category.
	
	- GOslim_agr_unassigned_GOs_clustersMF.txt : GO cluster representatives of clustered MF GO terms that could not be assigned to a Alliance for Genomics Resources (AGR) GO Slim GO category.
	
	- GOslim_unassigned_GO_cats_proportion_per_phylum.txt : proportion of unassigned GO terms for each of the GO terms categories for 2 GO Slims (AGR and general) per phylum.
	
	- unique_GOs_BP_all_phyla.txt : Biological process (BP) GO terms that were exclusively enriched in one animal phyla.
	
	- unique_GOs_CC_all_phyla.txt : Cellular component (CC) GO terms that were exclusively enriched in one animal phyla.
	
	- unique_GOs_MF_all_phyla.txt : Molecular function (MF) GO terms that were exclusively enriched in one animal phyla.
	
	- genes_after_filters.tar.gz : genes that remain after the different filters for each of the methods.
	
	- disorder_all.txt : disorder prediction of all proteins.
	
	- Taxon_list_subset.tsv : species metadata for plotting.
	
	- metazoa_phyla_tree.nwk : animal phyla phylogenetic tree used for plotting.
	
	- subset_all_isoforms_tree.nwk : subset of 93 animal species phylogenetic tree used for plotting.
	
	- Fantasia_computer_resources.txt : computer resources used by FANTASIA.
	
	- model_organisms_tree.nwk : model organisms phylogenetic tree used for plotting.
	
</details>
<details>
<summary><b><a href="https://doi.org/10.5281/zenodo.10717484">Part 2</a></b></summary>
</br>
Part 2 contains:

	- longest_isoforms_gopredsim_seqvec_F_to_O.tar.gz : GOPredSim GO annotation using SeqVec model for the longest isoform or species whose code first letter goes from F to O.
	
	- IC_longest_isoforms_gopredsim_prott5.tar.gz : Information content (IC) of the unfiltered GOPredSim-ProtT5 GO annotation of the longest isoforms of all species.
	
	- IC_longest_isoforms_gopredsim_seqvec.tar.gz : IC of the unfiltered GOPredSim-SeqVec GO annotation of the longest isoforms of all species.
	
	- IC_all_isoforms_eggnog_filtered_go_terms_cdhit.tar.gz : IC of the eggNOG-mapper GO annotation of all isoforms of a subset of 102 species. Isoforms removed by CD-HIT are filtered from this file (but included in the original eggNOG-mapper output).
	
	- IC_all_isoforms_gopredsim_prott5.tar.gz : IC of the GOPredSim-ProtT5 GO annotation of all isoforms of a subset of 102 species.
	
	- IC_all_isoforms_gopredsim_seqvec.tar.gz : IC of the GOPredSim-SeqVec GO annotation of all isoforms of a subset of 102 species.
	
</details>
<details>
<summary><b><a href="https://doi.org/10.5281/zenodo.10717774">Part 3</a></b></summary>
</br>
Part 3 contains:

  - longest_isoforms_gopredsim_seqvec_P_to_Z.tar.gz : GOPredSim GO annotation using SeqVec model for the longest isoform or species whose code first letter goes from P to Z.
  
</details>
<details>
<summary><b><a href="https://doi.org/10.5281/zenodo.10717783">Part 4</a></b></summary>
</br>
Part 4 contains:

  - all_isoforms_gopredsim.tar.gz : GOPredSim (ProtT5 and SeqVec) GO annotation for all isoforms for a subset of 102 species.
  
  - IC_longest_isoforms_deepgoplus.tar.gz : Information content (IC) of the unfiltered DeepGOPlus GO annotation of the longest isoforms of all species.
  
</details>
<details>
<summary><b><a href="https://doi.org/10.5281/zenodo.10717885">Part 5</a></b></summary>
</br>
Part 5 contains:

  - IC_longest_isoforms_eggnog_filtered_goterms_cdhit.tar.gz : Information content (IC) of the eggNOG-mapper GO annotation of the longest isoforms of all species (proteins filtered by CD-HIT removed).
  
</details>
<details>
<summary><b><a href="https://doi.org/10.5281/zenodo.10717910">Part 6</a></b></summary>
</br>
Part 6 contains:

	- model_organisms_semsim_go_cats.txt : semantic similarity separated by GO category between the GO annotations from GOPredSim-ProtT5 before and after removing a given model organism from the lookup dataset.
	
	- model_organisms_removed_confidence_min.txt : minimum reliability index ("confidence") per gene of GO annotations from GOPredSim-ProtT5 after removing a given model organism from the lookup dataset.
	
	- model_organisms_prott5.tar.gz : GO annotations from GOPredSim-ProtT5 after removing a given model organism from the lookup dataset.
	
	- model_organisms_orig_confidence_min.txt : minimum reliability index ("confidence") per gene of GO annotations from GOPredSim-ProtT5 before removing a given model organism from the lookup dataset.
	
	- all_isoforms_cdhit_clustr.tar.gz : CD-HIT clusters results for all isoforms for a subset of 102 species.
	
	- all_isoforms_larger_5k.tar.gz : headers of sequences that are more than 5000 aminoacids long after CD-HIT for all isoforms of a subset of 102 species.
	
	- longest_cdhit_clustr.tar.gz : CD-HIT clusters results for the longest isoforms of all species.
	
	- longest_larger_5k.tar.gz : headers of sequences that are more than 5000 aminoacids long after CD-HIT for the longest isoforms all species.
	
</details>

***
## Extended methods. Data processing and analyses
### 1. Data processing (up to the most filtered dataset) and Information Content (IC)
  - **EggNOG-mapper**: 
    1. Remove genes that do not have GO terms:
    
    ``python Scripts/data_processing/filter_go_terms_eggnog.py SPECIES.emapper.annotations SPECIES.emapper.annotations.filtered.goterms.txt``
    
    2. Remove genes that were filtered by CD-HIT:
    
    ``python Scripts/data_processing/filter_cdhit_eggnog.py SPECIES.pep SPECIES_cdhit100.pep SPECIES_genes_cdhit_removed.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.txt SPECIES.emapper.annotations.filtered.goterms.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.txt``
    
    3. Convert to a "standard" format:
    
    For longest isoform:
    
    ``python Scripts/data_processing/standard_output_eggnog.py SPECIES.emapper.annotations.filtered.goterms.cdhit.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.standard.txt``
    
    For all isoforms:
    
    ``python Scripts/data_processing/standard_output_eggnog-alliso.py SPECIES.emapper.annotations.filtered.goterms.cdhit.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.standard_alliso.txt``
    
    3. Convert to the format needed as input to calculate IC:
    
    ``python Scripts/data_processing/standard_to_IC.py SPECIES.emapper.annotations.filtered.goterms.cdhit.standard.txt SPECIES.emapper.annotations.filtered.goterms.cdhit.IC.txt``
    
    4. Calculate IC (example with longest isoforms):
    
    Instructions and scripts to calculate IC can be found in [https://github.com/cbbio/Compute_IC](https://github.com/cbbio/Compute_IC).
    
    ``python compute_IC.py SPECIES.emapper.annotations.filtered.goterms.cdhit.IC.txt``
    
    5. Filter by depth (remove GO terms that are close to the root):
    
    ``python Scripts/data_processing/FilterDepth.py SPECIES_IC_eggnog.tsv``
    
    **Note**: To use ``Scripts/data_processing/FilterDepth.py`` you must first create a python environment and activate it ``python -m venv venv; source venv/bin/activate; python3 -m pip install -r FilterDepth_requirements.txt``
    
  - **DeepGOPlus**: 
    1. Convert to a "standard" format:
    
    For longest isoform:
    
    ``python Scripts/data_processing/standard_output_deepgoplus.py SPECIES_deepgoplus.txt SPECIES_deepgoplus.standard.txt``
    
    For all isoforms:
    
    ``python Scripts/data_processing/standard_output_deepgoplus_alliso.py SPECIES_deepgoplus.txt SPECIES_deepgoplus.standard.alliso.txt``
    
    2. Convert to the format needed as input to calculate IC:
    
    ``python Scripts/data_processing/standard_to_IC.py SPECIES_deepgoplus.standard.txt SPECIES_deepgoplus.IC.txt``
    
    3. Calculate IC (example with longest isoform):
    
    Instructions and scripts to calculate IC can be found in [https://github.com/cbbio/Compute_IC](https://github.com/cbbio/Compute_IC).
    
    ``python compute_IC.py SPECIES_deepgoplus.IC.txt``
    
    4. Filter by DeepGOPlus reliability index (RI) thresholds:
    
    ``python Scripts/data_processing/filter_thresholds_deepgoplus.py SPECIES_deepgoplus.txt SPECIES_deepgoplus_filtered.txt SPECIES_deepgoplus.IC.txt``
    
    5. Filter by depth (remove GO terms that are close to the root):
    
    ``python Scripts/data_processing/FilterDepth.py SPECIES_deepgoplus_filtered``
    
    **Note**: To use ``Scripts/data_processing/FilterDepth.py`` you must first create a python environment and activate it ``python -m venv venv; source venv/bin/activate; python3 -m pip install -r FilterDepth_requirements.txt``
    
  - **GOPredSim**: 
    1. Filter by GOPredSim reliability index (RI) thresholds:
    
    ``python Scripts/data_processing/filter_thresholds_gopredsim.py SPECIES_GOPredSim/ FILTERED_path``
    2. Convert to the format needed as input to calculate IC:
    
    For longest isoform:
    
    ``bash Scripts/data_processing/IC_output_gopredsim.sh FILTERED_path IC_format_path SPECIES``
    
    For all isoforms:
    
    ``python Scripts/data_processing/standard_output_gopredsim_alliso.py FILTERED_path/ IC_format_path``
    
    ``python Scripts/data_processing/standard_to_IC.py IC_format_path/SPECIES_model_1_bpo_cco_mfo.standard_alliso.txt``
    
    3. Calculate IC (example with longest isoform):
    `
    Instructions and scripts to calculate IC can be found in [https://github.com/cbbio/Compute_IC](https://github.com/cbbio/Compute_IC).
    
    ``python compute_IC.py SPECIES_gopredsim_prott5.filtered.standard.tsv``

#### **IC plots**:
  Once IC has been calculated, we process the data using the scripts in the **``Scripts/IC_for_plots``** folder to obtain the input for the R plots phyla_plots.R, filters_plots.R and filters_plots_longiso_final.R (in **``Figures``** folder).
  
### 2. Semantic similarity
  To calculate the semantic similarity between the GO annotations of the different methods against the one from eggNOG-mapper, execute the scripts semsim_pipeline_go_categories.sh, semsim_pipeline_go_categories_deepgoplus.sh, semsim_pipeline_go_categories_seqvec.sh and semsim_pipeline_go_categories_prott5.sh located in the folder **``Scripts/Semantic_similarity/``**. These pipeline has the following steps:
  
  1. Obtain the list of genes annotated by each method.
  
  2. Obtain which genes are common for each combination (**``Scripts/Semantic_similarity/obtain_common_genes.py``**).
  
  3. Calculate semantic similarity (**``Scripts/Semantic_similarity/calculate_semsim.py``**).
  
  All semantic similarity information was fused for plotting using **``Scripts/Semantic_similarity/fuse_all_semsim_info_for_plot.sh``**. The outputs of this script were used in semsim_plots.R (in **``Figures``** folder)

  We also obtained the IC for the genes for which we estimated their semantic similarity with (**``Scripts/Semantic_similarity/obtain_ic_for_common_genes.sh``**). This files were used as input in the semsim_plots.R (in **``Figures``** folder)
  
### 3. Number of GO terms per gene
  We extracted the number of GO terms per gene using the following script: **Scripts/gos_per_gene/obtain_num_gos_per_gene_go_cat_subset_longest.sh**, and used it as input file in **``Figures/filters_plots.R``**.
  
### 4. GOPredSim-ProtT5 lookup dataset analyses in model organisms
  
  1. We generated new lookup datasets for each of the species by executing **``Scripts/model_organisms/create_new_lookup.sh``** (which calls **``Scripts/model_organisms/custom_lookup.py``** script).
  
  2. GOPredSim-ProtT5 was run using the new lookup datasets with **``Scripts/model_organisms/loop_GOPredSim_model_organisms_new_lookup.sh``**.
  
  3. To calculate the semantic similarity between the original GO annotation and the new one, we used this script: **``Scripts/model_organisms/compute_semsim_model_organisms.py``**.
  
  4. Minimum RI per gene was obtained with **``Scripts/model_organisms/awk_obtain_minimum_confidence.sh``**.
  
  5. Plots and other analyses were done with **``Figures/model_organisms_plots.Rmd``**.
  
### 5. All isoforms vs longest isoform analyses
  
  Scripts **``Scripts/Isoforms/execute_input_compare_allvslongest.sh``** (which calls the script **``Scripts/Isoforms/input_compare_allvslongest.sh``**) and **``Scripts/Isoforms/obtain_stats_number_genes_filters.sh``** create the statistics for comparing the number of genes with functional annotation when using the longest or all isoforms for all methods. These outputs are used in **``Figures/isoforms_plots.R``**.
  
  To calculate the semantic similarity between the per-gene annotation obtained when only using the longest isoform and when using all of them, we used the following scripts:
  
  1. We first obtained the GO terms for each of the genes with the two types of data (all and longest isoforms) for all the methods with **``Scripts/Isoforms/Isoforms_Semsim/obtain_go_data.sh``**.
  
  2. We Calculated the semantic similarity (per GO category) of the GO annotations with the scripts ``execute_array_eggnog.sh``, ``execute_array_deepgoplus.sh``, ``execute_array_prott5.sh`` and ``execute_array_seqvec.sh`` (which call the script ``calculate_semsim_all_isoforms_vs_longest_go_categories.py``) located in **``Scripts/Isoforms/Isoforms_Semsim/``**.
  
  3. To make the semantic similarity plots from  **``Figures/isoforms_plots.R``**, we combined the results with **``Scripts/Isoforms/Isoforms_Semsim/for_plot.sh``**.
  
### 6. GO enrichment

  1. Generate the required input for topGO from GOPredSim-ProtT5 annotations with **``Scripts/go_enrichment/obtain_input_files_for_topgo.sh``** (which executes **``Scripts/go_enrichment/from_gopredsim_to_topgo_format.py``**)
  
  2. Obtain per each species the subset of genes that were annotated by EggNOG-mapper with **``Scripts/go_enrichment/obtain_subset_genes_per_sp.sh``**.
  
  3. Esecute GO enrichment, clustering of GO terms and visualization plots with **``Figures/go_enrichment.Rmd``**.
  
### 7. Lookup dataset taxonomical information analysis

  To identify the taxonomical origin of the GO annotations transfered from the lookup database when executing GOPredSim (i.e. the taxon of the species the reference protein comes from) we executed the script **``Scripts/taxonomy_lookup/obtain_uniprot_matches_gopredsim_unfiltered_depth.sh``** (which executes **``Scripts/taxonomy_lookup/get_tax_uniprot_reference_gopredsim.py``**).
  
### 8. Disorder prediction

  1. We used the python implementation of [IUPred3](https://iupred.elte.hu/download_new) to calculate the disorder of each of the proteins of our dataset. As we have Multi-FASTA files that are not recognized by the IUPred3 scripts, and the results of the original script only computes per-residue disorder instead of a mean value per protein, we implemented a variation of the script (**``Scripts/disorder/iupred/iupred3_multifasta.py``**) that we execute in **``Scripts/disorder/calculate_disorder_seqs.sh``**.
  
  2. Plots and statistical analyses with this data is included in **``Figures/phyla_plots.R``**.
  
### 9. FANTASIA computer resources usage

  Results of the memory consumption and execution time of FANTASIA were plotted using **``Figures/computer_resources.R``**.

