function chooseNextProb_flip(appHandle)

% In a staircase procedure, returns index and value of parameters for the
% next trial, based on correct or incorrect response to the current trial.
% When done with staircase procedure return index larger than crossvals,
% and ControlLoop2 will terminate session

% Should not pick trial.cntr, should just append appropriate index to the
% end of trial.list and trial.cntr will be incremented.

global debug

if debug
    disp('Entering chooseNextProb_flip')
end


data = getappdata(appHandle,'protinfo');
trial = getappdata(appHandle,'trialInfo');
savedInfo = getappdata(appHandle,'SavedInfo');

within = data.condvect.withinStair;
activeStair = data.activeStair;
activeRule =data.activeRule;

i = strmatch('MOTION_TYPE',{char(data.configinfo.name)},'exact');
motiontype = data.configinfo(i).parameters;

lastInd = trial(activeStair,activeRule).list(trial(activeStair,activeRule).cntr);
if isfield(within.parameters, 'moog')
    within_vect = within.parameters.moog;
else
    within_vect = within.parameters;
end
lastDir = within_vect(lastInd);

if motiontype == 3  % For 2I we need to handle response in different way.
    currOrd = getappdata(appHandle,'Order'); % setting directions same order as in trajectory
    %if currOrd(1) == 2
        lastDir = lastDir - 8;
    %else
        %lastDir = 8 - lastDir;
    %end
end

if debug
    probDif = rand
    probAlt = rand
else
    probDif = rand;
    probAlt = rand;
end
i = strmatch('STAIR_UP_PCT',{char(data.configinfo.name)},'exact');
stairUp = data.configinfo(i).parameters/100;
i = strmatch('STAIR_DOWN_PCT',{char(data.configinfo.name)},'exact');
stairDown = data.configinfo(i).parameters/100;
i = strmatch('ERR_ALT_PROB',{char(data.configinfo.name)},'exact');
errAlt = data.configinfo(i).parameters/100;
i = strmatch('CORR_ALT_PROB',{char(data.configinfo.name)},'exact');
corrAlt = data.configinfo(i).parameters/100;


if savedInfo(activeStair,activeRule).Resp(data.repNum).corr(trial(activeStair,activeRule).cntr)
    if probDif <= stairUp
        if debug
            disp('Correct: Go Harder')
        end
        if lastDir > 0
            nextInd = lastInd - 1;
        else
            nextInd = lastInd + 1;
        end
        if probAlt < corrAlt
            if debug
                disp('And switch direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                if(lastDir > 0)
                    nextDir = 8-within_vect(lastInd); 
                else
                    nextDir = 8+within_vect(lastInd); 
                end
            else
                if(lastDir > 0)
                    nextDir = 8 + 8 -within_vect(nextInd); 
                else
                    nextDir = 8 + 8 -within_vect(nextInd); 
                end
            end
        else
            if debug
                disp('Same Direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                nextDir = within_vect(lastInd);
            else
                nextDir = within_vect(nextInd);
            end
        end
    end
elseif savedInfo(activeStair,activeRule).Resp(data.repNum).incorr(trial(activeStair,activeRule).cntr)
    if probDif <= stairDown
        if lastDir > 0
            nextInd = lastInd + 1;
        else
            nextInd = lastInd - 1;
        end
        if debug
            disp('Wrong: Go Easier')
        end
        if probAlt < errAlt
            if debug
                disp('And switch direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                if(lastDir > 0)
                    nextDir = 8-within_vect(lastInd); 
                else
                    nextDir = 8+within_vect(lastInd); 
                end
            else
                if(lastDir > 0)
                    nextDir = 8 + 8 -within_vect(nextInd); 
                else
                    nextDir = 8 + 8 -within_vect(nextInd); 
                end
            end
        else
            if debug
                disp('Same Direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                nextDir = within_vect(lastInd);
            else
                nextDir = within_vect(nextInd);
            end
        end
    end
elseif savedInfo(activeStair,activeRule).Resp(data.repNum).null(trial(activeStair,activeRule).cntr)
       if probDif <= stairDown
        if lastDir > 0
            nextInd = lastInd + 1;
        else
            nextInd = lastInd - 1;
        end
        if debug
            disp('Wrong: Go Easier')
        end
        if probAlt < errAlt
            if debug
                disp('And switch direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                if(lastDir > 0)
                    nextDir = 8-within_vect(lastInd); 
                else
                    nextDir = 8+within_vect(lastInd); 
                end
            else
                if(lastDir > 0)
                    nextDir = 8 + 8 -within_vect(nextInd); 
                else
                    nextDir = 8 + 8 -within_vect(nextInd); 
                end
            end
        else
            if debug
                disp('Same Direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                nextDir = within_vect(lastInd);
            else
                nextDir = within_vect(nextInd);
            end
        end
    end
elseif savedInfo(activeStair,activeRule).Resp(data.repNum).dontKnow(trial(activeStair,activeRule).cntr)
    if probDif <= stairDown
        if lastDir > 0
            nextInd = lastInd + 1;
        else
            nextInd = lastInd - 1;
        end
        if debug
            disp('Wrong: Go Easier')
        end
        if probAlt < errAlt
            if debug
                disp('And switch direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                if(lastDir > 0)
                    nextDir = 8-within_vect(lastInd); 
                else
                    nextDir = 8+within_vect(lastInd); 
                end
            else
                if(lastDir > 0)
                    nextDir = 8 + 8 -within_vect(nextInd); 
                else
                    nextDir = 8 + 8 -within_vect(nextInd); 
                end
            end
        else
            if debug
                disp('Same Direction')
            end
            if nextInd == 0 || nextInd > length(within_vect)
                nextDir = within_vect(lastInd);
            else
                nextDir = within_vect(nextInd);
            end
        end
    end
else
    disp('Something screwed up!')
end

nextInd=find(within_vect == nextDir);
if ~isempty(nextInd)
    
    if length(nextInd) >= 2
        if rand > .5 
            nextInd = nextInd(1)
        else
            nextInd = nextInd(2)
        end
    end
    
    trial(activeStair,activeRule).list = [trial(activeStair,activeRule).list nextInd];
else
    trial(activeStair,activeRule).list = [trial(activeStair,activeRule).list lastInd];
end
if debug
    trial(activeStair,activeRule).list
end

setappdata(appHandle,'trialInfo',trial);

if debug
    disp('Exiting chooseNextProb_flip')
end

