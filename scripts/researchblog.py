#!/usr/bin/python

def parsing(sysargs):
    return 


def invoke_mtsend(command):
    mtsendloc = "mtsend.py"
    mtsendrc = "-c ~/.scripts/mtsendrc_researchblog"
    mtsendcmd = " ".join([mtsendloc, mtsendrc, command])
    return mtsendcmd

def get_attachments(infile, attachments, blog):
    file_list = files_in(infile, blog)
    for file in file_list:
        if file not in attachments:
            if (ftype(file) == "unknown"):
                get_attachments(file, attachments, blog)
            else:
                attachments.append(file)

    return

def files_in(file, blog):
    from re import findall
    from os.path import exists
    flist = []
    if (exists(file)):
        f = open(file, 'r')
        fdata = f.read()
        flist = findall("[A-Za-z0-9\.\-\_\%\/]+\.[A-Za-z\_]+", fdata)
        blog.extend(findall("\#blog (.*)", fdata))

    return flist

def ftype(file):
    from re import split
    myext = split("\.", file)[-1]  # assuming the extension is the last dot
    ftype = "unknown"
    extensions = {  'image' : ['png', 'jpg', 'gif'],
                    'text' : ['data', 'inp', 'job', 'gnuplot'] }#, 'out']  }
    for atype in extensions.keys():
        if myext in extensions[atype]:
            from os.path import exists
            if exists(file):
                ftype = atype
            else:
                ftype = 'dne'

    return ftype


# generate the post (email2blog)

import re

def special_tags(text):
    taglabel = re.compile("\#tag\s+(\w*)")
    tags = re.findall(taglabel, text)
    return tags

def block_tags(text):
    run_RE   = re.compile("RUN(?:TYPE)?\s+(\w*)")
    pot_RE   = re.compile("POT(?:ENTIAL)?\s+(\w*)")
    integ_RE = re.compile("INTEG(?:RATOR)?\s+(\w*)")
    tags = []
    for regexp in [run_RE, pot_RE, integ_RE]:
        tags.extend(re.findall(regexp, text))

    return tags

def parameter_tags(text):
    param_names = [ 'HK_OVERLAP', 'HK_PREFACTOR', 'HESS', \
                    'MC_GENERATE' ]
    tags = []
    for name in param_names:
        atag = re.search("(" + name + ")" + "\s*\=\s*(\w*)", text)
        if (atag):
            tagout = atag.group(1) + '_' + atag.group(2)
            tags.append(tagout)

    return tags


def get_tags(text):
    tags = special_tags(text)
    tags.extend(block_tags(text))
    tags.extend(parameter_tags(text))

    for i in range(len(tags)):
        tags[i] = tags[i].lower()
    
    return tags



def get_revisions(filedata):
    exes = ['dynamiq']
    revs = []
    for prog in exes:
        revs.extend(re.findall("(" + prog + ")" + "[-_]r([0-9]+)", filedata))

    return revs

def get_captions(filedata):
    caplines = re.findall("\#caption.*", filedata)
    caps = { }
    dafile = ""
    for line in caplines:
        searchres = re.search("\#caption.*\{(\S+)}\s+(.*)", line)
        if (searchres):
            dafile = searchres.group(1)
            caps[dafile] = searchres.group(2)
        else:
            addline = re.search("\#caption\s+(.*)", line).group(1)
            caps[dafile] = caps[dafile] + " " + addline
            
    return caps

def write_blog_entry(f,title, attachments, revs, tags, caps, blog, postid):
    basestr = "wp-content/uploads/"
    f.write("TITLE: "+title+'\n')
    f.write("ALLOW COMMENTS: 1\n")
    f.write("STATUS: publish\n")
    tagstr = ", ".join(tags)
    f.write("KEYWORDS: "+ tagstr + "\n")
    f.write( "-----\n")
    f.write( "BODY:\n")

    nimg = 0
    ntxt = 0
    ndne = 0
    for file in attachments:
        if ftype(file) == 'image':
            nimg = nimg+1
        if ftype(file) == 'text':
            ntxt = ntxt+1
        if ftype(file) == 'dne':
            ndne = ndne+1

    # images
    if (nimg):
        f.write("<div type=\"research_images\">")
        for file in attachments:
            if ftype(file) == 'image':
                wpfile = str(postid) + "_" + file
                wpfile = re.sub("/", "_", wpfile)
                wpfile = basestr + re.sub("_", "-", wpfile)
                f.write("<img src=\"" + wpfile + "\" width=\"450\" />\n")
                if file in caps:
                    f.write("<p>" + caps[file] + "</p>\n")
        f.write("</div>\n")

    # blog data
    f.write("\n"+blog+"\n")
    
    # text files
    if (ntxt):
        f.write("<div type=\"research_text\">\n")
        f.write("<h3>Other associated files:</h3>\n")
        f.write("<ul>\n")
        for file in attachments:
            if ftype(file) == 'text':
                wpfile = str(postid) + "_" + file.lower()
                wpfile = re.sub("/", "_", wpfile)
                wpfile = re.sub("_", "-", wpfile)
                wpfile = basestr + re.sub("\.", "", wpfile)
                # god I hate wordpress for that
                f.write("<li><a href=\"" + wpfile + ".txt\">" + file + "</a>")
                if file in caps:
                    f.write(": " + caps[file])
                f.write("</li>\n")
        f.write("</ul>\n")
        f.write("</div>\n")

    # dne
    if (ndne):
        f.write("<div type=\"research_dne\">\n")
        f.write("<strong>The following files were referred to, but could not be found:</strong>\n")
        f.write("<ul>\n")
        for file in attachments:
            if ftype(file) == 'dne':
                f.write("<li>" + file)
                if file in caps:
                    f.write(": " + caps[file])
                f.write("</li>\n")
        f.write("</ul>\n")
        f.write("</div>\n")

    return


import sys, os, time
from os.path import exists

if __name__ == "__main__":
    jobfiles = sys.argv[1:] # from parser

    # extract names of all the files we'll be sending to the server
    attachments = jobfiles
    blog = []
    for file in jobfiles:
        get_attachments(file, attachments, blog)

    # extract all the tags and metadata contained in those files
    revs = []
    tags = []
    caps = { }
    for file in attachments:
        if exists(file):
            f = open(file, 'r')
            data = f.read()
            revs.extend(get_revisions(data))
            tags.extend(get_tags(data))
            captions = get_captions(data)
            for fname in captions.keys():
                caps[fname] = captions[fname]


    i=0
    titles = []
    for file in jobfiles:
        if exists(file):
            jobdata = open(file).read()
            titles.extend(re.findall("\#title (.*)", jobdata))
    title = titles[0]
    #print revs
    #print tags
    #print caps
        


    # get next post number (mtsend)
    #blogdata = os.popen(invoke_mtsend("-G -"))
    #postID = re.search("POSTID: ([0-9]+)", blogdata.read()).group(1)
    #postID = int(postID) + 1
    #postdir = "post"+str(postID)
    postID = str(time.time())
    postID = re.sub("\.", "x", postID)
    postdir = postID

    blogfilename = postdir + ".blogpost"
    blogfile = open(blogfilename, 'w')
    blog = " ".join(blog)
    write_blog_entry(blogfile,title,attachments,revs,tags,caps,blog,postID)
    
    # upload all the files (mtsend)
    for file in attachments:
        if exists(file):
            savedfileloc = postdir+"_"+file
            savedfileloc = re.sub("/", "_", savedfileloc)
	    savedfileloc = re.sub("_", "-", savedfileloc)
            cmd = ""
            if ftype(file) == 'image':
	        os.system("cp "+file+" "+savedfileloc)
                cmd = invoke_mtsend("-U "+savedfileloc+" < "+savedfileloc)
            if ftype(file) == 'text':
                savedfileloc = re.sub("\.", "", savedfileloc)
	        os.system("cp "+file+" "+savedfileloc)
                cmd = invoke_mtsend("-U "+savedfileloc+".txt < "+savedfileloc)
            os.system(cmd)

    blogfile.close()
    os.system(invoke_mtsend("-U "+blogfilename+".txt < "+blogfilename))
    cmd = invoke_mtsend("-N < " + blogfilename)
    os.system(cmd)


