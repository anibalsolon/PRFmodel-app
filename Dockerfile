FROM garikoitz/prfanalyze-vista:latest

RUN chmod 777 /solve.sh
RUN chmod 777 /compiled/run_prfanalyze_vista.sh
RUN chmod 777 /compiled/prfanalyze_vista