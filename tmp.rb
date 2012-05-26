require 'rubygems'
require 'json'
tmp = JSON.parse('{
   "id": "1036380702",
   "name": "Arvind Shrihari",
   "first_name": "Arvind",
   "last_name": "Shrihari",
   "link": "http://www.facebook.com/arvind.shrihari",
   "hometown": {
      "id": "111948785483165",
      "name": "Cupertino, California"
   },
   "work": [
      {
         "employer": {
            "id": "20528438720",
            "name": "Microsoft"
         },
         "location": {
            "id": "108212625870265",
            "name": "Mountain View, California"
         },
         "position": {
            "id": "102896856432352",
            "name": "Software Development Engineer Intern"
         },
         "start_date": "2011-05",
         "end_date": "2011-05"
      },
      {
         "employer": {
            "id": "115345968480189",
            "name": "Boeing Company"
         },
         "location": {
            "id": "111723635511834",
            "name": "Bellevue, Washington"
         },
         "position": {
            "id": "134048509994136",
            "name": "System Architect Intern"
         },
         "start_date": "2010-05",
         "end_date": "2010-08"
      },
      {
         "employer": {
            "id": "107572525938726",
            "name": "IBM"
         },
         "location": {
            "id": "106377336067638",
            "name": "Bangalore, India"
         },
         "position": {
            "id": "130537396991540",
            "name": "Systems Intern"
         },
         "start_date": "2009-05",
         "end_date": "2009-08"
      }
   ],
   "education": [
      {
         "school": {
            "id": "114659898545497",
            "name": "Monta Vista High"
         },
         "year": {
            "id": "110800455622843",
            "name": "2007"
         },
         "type": "High School"
      },
      {
         "school": {
            "id": "7133766387",
            "name": "Carnegie Mellon University"
         },
         "year": {
            "id": "112868578750054",
            "name": "2011"
         },
         "concentration": [
            {
               "id": "111139868924643",
               "name": "Information Systems"
            },
            {
               "id": "111064955595556",
               "name": "Computer Science"
            }
         ],
         "type": "College"
      },
      {
         "school": {
            "id": "7133766387",
            "name": "Carnegie Mellon University"
         },
         "degree": {
            "id": "138858869473505",
            "name": "Masters"
         },
         "year": {
            "id": "112868578750054",
            "name": "2011"
         },
         "concentration": [
            {
               "id": "110896515617404",
               "name": "Information Systems Management"
            }
         ],
         "type": "Graduate School"
      }
   ],
   "gender": "male",
   "timezone": -5,
   "locale": "en_US",
   "verified": true,
   "updated_time": "2011-01-29T04:36:23+0000"
}')
puts tmp["id"]

