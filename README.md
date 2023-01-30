# Grafana data sources backup
Grafana API based, bash supported, data sources backup solution.

## Key features
* Export data sources and auto commit to repository of your choice.
* Import previously exported data sources to the same or different Grafana instance.
* Works with Jenkins OTB.
* Flexible implementation allows for easy adoption to other automation servers.

## Stack
tool                                                                                              | function
---                                                                                               | ---
bash                                                                                              | export/import data sources, commit data sources to git repo
Docker                                                                                            | create Jenkins agent image, with necessary toolset 
Jenkins                                                                                           | export/import tasks orchestrator

## Prerequisites
* Jenkins, with Docker agent, to run export/import jobs.
* Grafana api key, to access data sources.
* Git repo for exported data sources, as well as ssh keys for read/write access.

## Installation
1. Create copy of this repo.
2. Update Jenkins pipelines with your custom configuration, if necessary.  
> **NOTE**  
> Remember to modify bash scripts permissions:  
> `git update-index --add --chmod=+x my-script.sh` 
3. Add Grafana and git credentials to Jenkins Credential store.
4. Add export and import as two separate Multibranch pipelines.
> **NOTE**  
> Initial run of both jobs will likely fail, since job parameters need to be populated first.