alltoall.cpp, barrier.cpp - бенчмарки с коллективными операциями. представляют цикл с соотв. операцией

alltoall.cpp:
Входные параметры:
	- имя текстового файла для сохранения инф о запуске задачи на СК
	- размер пересылаемого сообщения
	- общее число итераций в БОЛЬШОМ цикле. от него зависит время работы бенчмарка
	- имя .csv файла, в который сохраняется время выполнения МАЛЫХ циклов (БОЛЬШОЙ цикл разбивается на несколько частей. каждая часть замеряется отдельно)
	- количество операций в МАЛОМ цикле

barrier.cpp
Входные параметры:
	- имя текстового файла для сохранения инф о запуске задачи на СК
	- общее число итераций в БОЛЬШОМ цикле. от него зависит время работы бенчмарка
	- имя .csv файла, в который сохраняется время выполнения МАЛЫХ циклов (БОЛЬШОЙ цикл разбивается на несколько частей. каждая часть замеряется отдельно)
	- количество операций в МАЛОМ цикле

Для запуска бенчмарков на СК есть скрипты с именами вида
	launch_script_{название коллективной операции}.sh - чистый запуск без шума
	launch_script_{название коллективной операции}_x1.sh - запуск с шумом
в скриптах входные параметры:
	- число узлов для запуска
	- число процессов на узел
	- сколько раз поставить задачу в очередь
	- сколько ждать между сабмитами
	- размер сообщений (только для alltoall, в скрипте barrier этого пар-ра нет)
	- число итераций в БОЛЬШОМ цикле
	- число итераций в МАЛОМ цикле (для какого числа операций измеряется время)
Нужно исправить PATH_TO_DIR.
Пример:
	nohup launch_script_alltoall_x1.sh 2 14 2 15m 256 100000 10000 & - 2 раза запустится alltoall с шумом на 28 процессов

в sbatch_files лежат скрипты для постановки задач в очередь СК (очень похожи на ompi)
	my_sbatch_clean - поставить без шума через скрипт task_affinity/affinity_task.sh (скрипт устанавливает привязку к ядрам, строго на 0-13 ядра. если нужна другая привязка, нужно вручную изменить)
	my_sbatch_x1 - поставить бенчмарк c шумом через скрипт noise_affinity/simple_noise_affinity_same_core.sh (скрипт устанавливает привязку к 1-му ядру каждого узла, там же выполняется бенчмарк. если нужна другая привязка, нужно вручную изменить)

в noise_affinity лежит простой генератор шума (0.9с ничего не делает, 0.1с что-то вычисляет на протяжении 10 минут). До запуска нужно скомпилировать, в simple_noise_affinity_same_core.sh записать имя исполняемого файла

в dimmon_affinity лежит скрипт для запуска системы мониторинга DiMMon, которая должна быть предварительно установлена пользователю.