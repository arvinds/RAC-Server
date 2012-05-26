import java.io.*;
import java.net.*;
public class Test{
    public void HttpPostRequest(String targetUrl, String content) {
                 
      String response = "";        
         
      try {
            URL url = new URL(targetUrl);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            // Set connection parameters.
            conn.setRequestMethod("POST");
            conn.setDoInput (true);
            conn.setDoOutput (true);
            conn.setUseCaches (false);
            // Make server believe we are form data...
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");                      
                                   
            // Create the ouput stream
            BufferedWriter out = new BufferedWriter( new OutputStreamWriter(conn.getOutputStream()));

            // Write out the bytes of the content string to the stream.
            out.write(content);
            out.flush ();
            out.close ();

            // Read response from the input stream.                    
            BufferedReader in = new BufferedReader (new InputStreamReader(conn.getInputStream ()));
            String temp;
            while ((temp = in.readLine()) != null){
                  response += temp + "\n";
            }
            temp = null;
            in.close ();

            // checking the connection headers
            String header = null;
            String headerValue = null;
            int index = 0;
            while ((headerValue = conn.getHeaderField(index)) != null)
            {
                  header = conn.getHeaderFieldKey(index);

                  if (header == null)
                        System.out.println(headerValue);
                  else
                        System.out.println(header + ": " + headerValue);

                  index++;
            }
            System.out.println("Server response:\n'" + response + "'");
      }
      catch (Exception e){
            e.printStackTrace();
      }
    }

    public static void main(String[] args){
      String params = "action_name=read&" +
          "content_name=content&"+
          "content_guid=blah&"+
          "content_metadata='its really long..'&"+
          "content_image=blah&"+
          "owner_guid=arvinds&"+
          "requester_guid=alice";
      new Test().HttpPostRequest("http://saucers.cups.cs.cmu.edu:3000/requests",params);
 }
}

