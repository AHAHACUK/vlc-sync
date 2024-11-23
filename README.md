# VLC-sync

A simple dart command-line program that syncs up two VLC media players.

How can you use it?  
I, for example, use it to simultaneously watch videos with my friends in two difference languages.
We open the same video on separate machines, then sync them up with this program. I watch in one audio track, they watch in another.  
And if we want to pause or rewind video, then only one of us should do it, and it will be copied to other.  

## Setup
You need to enable HTTP control in VLC player at both machines.  
Use instruction here: https://wiki.videolan.org/Documentation:Modules/http_intf/

Also make sure to set password:  
https://wiki.videolan.org/Documentation:Modules/http_intf/#Access_control

Run programm with these arguments:  
  -target [ip:port] [password] (machine that controls the other one)  
  -mirror [ip:port] [password] (machine that being controlled by the first one)  
  -interval [time] (interval in milliseconds between sync calls)

Example:  
 -target 127.0.0.1:8080 1234  
 -mirror 192.168.0.1:8080 1234  
 -interval 10  

**IMPORTANT NOTE**. The password you type in VLC GUI is not the same you need to pass in arguments.  
They encode it somehow, and I don't realy know what exact algorithm is.   
You can get required password with these steps:   
- Run VLC player, open web-browser  
- Open web control panel (http://localhost:8080/ with default settings)  
- Open web-browser Debug panel (F12 in most browsers)  
- Open Network Tab  
- Click on any status.xml request
- Look for Request Header - Authorization.
  
It should be something like "Basic g2t12t615".  
Use this value AFTER "Basic" for password in arguments.  
In this examle my password is "g2t12t615".  

## Features
- If target machine pauses video, the mirror machine pauses as well  
- If target machine resumes video, the mirror machine resumes as well  
- If target machine rewind video, the mirror machine rewinds as well  
