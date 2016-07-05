--test_scheduler.lua
package.path = package.path..";../?.lua"

Scheduler = require("schedlua.scheduler")()
Task = require("schedlua.task")
local taskID = 0;
--local pArray = {};

local function getNewTaskID()
	taskID = taskID + 1;
	return taskID;
end

local function spawn(scheduler, func, priority, ...)
	local task = Task(func, ...)
	task.TaskID = getNewTaskID();
--	pArray[task.TaskID] = priority;
	scheduler:scheduleTask(task, priority, {...});
	
	return task;
end


local function task1(task2)
	--print("first task, first line")
	--Scheduler:yield();
	--print("first task, second line")

	while (true) do
		print ("task1 running")
		if t2:getStatus() == "dead" then
		break;
	 	end
		Scheduler:yield()
	end

end

local function task2()
	print("second task, only line")
end

local function main()
	t2 = spawn(Scheduler, task2, 2)
	local t1 = spawn(Scheduler, task1, 1, t2)

	while (true) do
--		print("STATUS: ", t1:getStatus(), t2:getStatus())
		if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
			break;
		end
		Scheduler:step()
	end
end

main()


