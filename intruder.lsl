integer hide_tx = 0;
integer old_av_num = 0;
string wwGetSLUrl()
{
    string globe = "http://maps.secondlife.com/secondlife";
    string region = llGetRegionName();
    vector pos = llGetPos();
    string posx = (string)llRound(pos.x);
    string posy = (string)llRound(pos.y);
    string posz = (string)llRound(pos.z);
    return (globe + "/" + llEscapeURL(region) +"/" + posx + "/" + posy + "/" + posz);
}

default
{
    state_entry()
    {
        llSay(0, "BoniSoft Logger is Active!");
        llSay(0, "Connecting to database....");
        llSetTimerEvent(5);
        llSetText("Logger Security...\nBoni!Ware\n\nConnected...\n\n\n\n\n.\n\n\n.\n\n\n\n\n\n\n.\n\n\n\n.\n\n\n.", <0,1,0>, 1.0);
        // if no avatars, abort avatar listing process and give a short notice
        list avatarsInRegion = llGetAgentList(AGENT_LIST_REGION, []);
        integer numOfAvatars = llGetListLength(avatarsInRegion);
        if (!numOfAvatars){
            llOwnerSay("No avatars found within the region!");
            return;
        }else{
            integer index;
             while (index < numOfAvatars){
                key id = llList2Key(avatarsInRegion, index);
                string name = llKey2Name(id);
                vector pos = llList2Vector(llGetObjectDetails(id, [OBJECT_POS]),0);
                float dist = llSqrt((pos.x*pos.x)+(pos.y*pos.y));
                llSay(0,"DATA FETCHED: "+(string)id+" "+name+" "+(string)dist+" "+wwGetSLUrl());
                llHTTPRequest("https://yourdomain.000webhostapp.com/SLogger/BonLoglk.php?udid="+(string)id+"&nme="+name+"&plce="+wwGetSLUrl()+"&dist="+(string)dist,[],"");
                //llOwnerSay(name + " [ " + (string)id + " ]");
                ++index;
             }
        }
    }
    touch_start(integer det){
     llSay(0,"You may check the logs on this webpage: https://yourdomain.000webhostapp.com/SLogger/index.php");
     if(hide_tx == 1){
         llSetText("",<1,1,1>,0.0);
         hide_tx = 0;
     }else{
        llSetText("Logger Security...\nBoni!Ware\n\nConnected...\n\n\n\n.\n\n\n.\n\n\n\n\n\n\n.\n\n\n\n.\n\n\n.", <0,1,0>, 1.0);
        list avatarsInRegion = llGetAgentList(AGENT_LIST_REGION, []);
        integer numOfAvatars = llGetListLength(avatarsInRegion);
        if (!numOfAvatars){
            llOwnerSay("No avatars found within the region!");
            return;
        }else{
            integer index;
             while (index < numOfAvatars){
                key id = llList2Key(avatarsInRegion, index);
                string name = llKey2Name(id);
                vector pos = llList2Vector(llGetObjectDetails(id, [OBJECT_POS]),0);
                float dist = llSqrt((pos.x*pos.x)+(pos.y*pos.y));
                llSay(0,"DATA FETCHED: "+(string)id+" "+name+" "+(string)dist+" "+wwGetSLUrl());
                llHTTPRequest("https://yourdomain.000webhostapp.com/SLogger/BonLoglk.php?udid="+(string)id+"&nme="+name+"&plce="+wwGetSLUrl()+"&dist="+(string)dist,[],"");
                //llOwnerSay(name + " [ " + (string)id + " ]");
                ++index;
             }
        }
         hide_tx = 1;
     }    
    }
    timer(){
        list avatarsInRegion = llGetAgentList(AGENT_LIST_REGION, []);
        integer numOfAvatars = llGetListLength(avatarsInRegion);
        if(old_av_num != numOfAvatars){
        if (!numOfAvatars){
            //llOwnerSay("No avatars found within the region!");
            return;
        }else{
            integer index;
             while (index < numOfAvatars){
                key id = llList2Key(avatarsInRegion, index);
                string name = llKey2Name(id);
                vector pos = llList2Vector(llGetObjectDetails(id, [OBJECT_POS]),0);
                float dist = llSqrt((pos.x*pos.x)+(pos.y*pos.y));
               // llSay(0,"DATA FETCHED: "+(string)id+" "+name+" "+(string)dist+" "+wwGetSLUrl());
                llHTTPRequest("https://yourdomain.000webhostapp.com/SLogger/BonLoglk.php?udid="+(string)id+"&nme="+name+"&plce="+wwGetSLUrl()+"&dist="+(string)dist,[],"");
                //llOwnerSay(name + " [ " + (string)id + " ]");
                ++index;
             }
        }
    }
    old_av_num = numOfAvatars;
    }
}
