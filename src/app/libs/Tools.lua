_G.Tools = {};

function Tools:Trace(obj,nType,...) 
    if not Option.bShowTraceInfo then 
        return ;
    end 
	local sType = "[Log] ";
	if nType == 1 then 
		sType = "[Log] " 
	elseif nType == 2 then 
		sType = "[Warn] " 
	elseif nType == 3 then 
		sType = "[Error] " 
	else 
		sType = "[Log] "
    end  
    local args = {...};
    local str = "["..obj.__cname.." "..os.date("%c").."] "..sType;
    for i,v in ipairs(args) do 
		str = str..tostring(v).." ";
    end
    print(str.."");
    if Option.bMakeLog then 
		local file = io.open('gc.log', 'a')
		if file ~= nil then 
			file:write(str.."\n");
			file:close();
		end
    end
end