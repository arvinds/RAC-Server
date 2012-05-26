def get_status
   status = 1;
   return case status
     when 0 then ""
     when 1 then ""
     when 2 then "approved"
     when 3 then "rejected"
   end
end

return 
