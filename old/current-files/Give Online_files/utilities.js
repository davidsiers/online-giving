function formatPhone(phoneField)
{
	var strph = new String(phoneField.value).replace(/^\s+|\s+$/g,"");
	var strtemp = strph;
	oldPhone = strph ;
	
	if (strph.charCodeAt(0) == "+".charCodeAt(0))
	{
	    //Leave it alone
	    phoneField.value =  strph;
	}
	else
	{
	    //Remove 1 from 19015550000
	    if (oldPhone.charCodeAt(0) == "1".charCodeAt(0) && oldPhone.length == 11) 
	    {
       	    oldPhone =  oldPhone.substr(1);   			 
	    }
	    //555-0000
	    if (oldPhone.length == 7)
	    {
		    strtemp = oldPhone.substr(0,3) + '-' + oldPhone.substr(3);
   	    }//(901) 555-0000
	    else if (oldPhone.length == 10)
        {    
		    strtemp = '('+ oldPhone.substr(0,3) + ') ' + oldPhone.substr(3,3) + '-' + oldPhone.substr(6,4);
	    }
        else  
        {
            strtemp = oldPhone;
        }
        
	    phoneField.value = strtemp;    	
    }
}

function Round_Decimals(original_number, decimals) 
{
    var result1 = original_number * Math.pow(10, decimals);
    var result2 = Math.round(result1);
    var result3 = result2 / Math.pow(10, decimals);
    return addCommas(Pad_With_Zeros(result3, decimals));
}

function Pad_With_Zeros(rounded_value, decimal_places) 
{
    var value_string = rounded_value.toString();
    var decimal_location = value_string.indexOf(".");
    if (decimal_location == -1) 
    {
        decimal_part_length = 0;
        value_string += decimal_places > 0 ? "." : "";
    }
    else 
    {
        decimal_part_length = value_string.length - decimal_location - 1;
    }
    var pad_total = decimal_places - decimal_part_length;
    if (pad_total > 0) 
    {
        for (var counter = 1; counter <= pad_total; counter++) 
            value_string += "0";
	}
    return value_string;
}
function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}