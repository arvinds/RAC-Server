import pycurl
from urllib2 import urlopen
from base64 import encode
from hashlib import sha224


c = pycurl.Curl()
content = "secret letter 2"
content_image_url = "http://www.wwtt.org/HEART1.gif"
values = [
          ("action_name", "read"),
          ("content_name", content),
          ("content_guid", sha224(content).hexdigest()),
          ("content_metadata", "its really long.."),
          ("content_image", urlopen(content_image_url).read().encode('base64')),
          ("owner_guid", "yang_facebook"),
          ("requester_guid","aaghasar")]

c.setopt(c.URL, "http://saucers.cups.cs.cmu.edu:3000/requests")
c.setopt(c.HTTPPOST, values)

c.perform()
c.close()
