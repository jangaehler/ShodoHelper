LOG_START=------- $(@) START -------
LOG_STOP=------- $(@) STOP  -------

usage:
	@echo
	@echo " - make bootstrap              >> bootstrap local_develop (data)"
	@echo

bootstrap:
	@echo $(LOG_START)
	git clone https://github.com/parsimonhi/animCJK.git assets/animCJK
	rm -rf assets/animCJK/samples
	rm assets/animCJK/*.php
	@echo $(LOG_STOP)