update_states_timer = timer;
update_states_timer.StartDelay = 0;
update_states_timer.Period = est_update_period;
update_states_timer.ExecutionMode = 'fixedRate';
update_states_timer.TasksToExecute = Inf;
update_states_timer.TimerFcn = @(~, ~) update_states;

start(update_states_timer)