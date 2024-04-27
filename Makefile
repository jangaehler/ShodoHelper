LOG_START=------- $(@) START -------
LOG_STOP=------- $(@) STOP  -------

usage:
	@echo
	@echo " - make bootstrap              >> bootstrap local_develop (data)"
	@echo

bootstrap:
	@echo $(LOG_START)
	git clone https://github.com/KanjiVG/kanjivg.git assets/kanjivg
	rm assets/kanjivg/*.py
	@echo $(LOG_STOP)