pos_loop = timer;
pos_loop.StartDelay = 1;
pos_loop.Period = est_propogate_period;
pos_loop.ExecutionMode = 'fixedRate';
pos_loop.TasksToExecute = Inf;
pos_loop.TimerFcn = @(~, ~) propogate_states;

start(pos_loop)