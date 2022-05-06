# DevOps
## Concourse pipeline to automate export and import functionality


We often come across situations where we need to export certain artifacts/data from one environment and import to other environment.

The concourse ci pipeline use export.sh and import.sh shell script files to perform the export/import operations using shell commands.
i.e. create a static script file and place in file system (accessible to the pipeline) to execute from within pipeline e.g. Static/concourse/scripts/export.sh

Similarly, we can use rest api calls to export data/configurations from source system and import it to targest system by invoking rest apis from within script.

Sample export.sh and import.sh files are atttached.

Pipeline expects some placeholder variables i.e. ((project.git.uri)), ((github-private-key)) etc. which can be replaced with actual values.
We can externalize other dynamic variables and respective values maintained in env. specific files i.e. env_var.yml to populate these variables values from env_var.yml file for respective environment.
Example : >> fly -t cloud set-pipeline -p test-new-plugin-pipeline -c testpipeline.yml --load-vars-from env_var.yml
