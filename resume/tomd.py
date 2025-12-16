#!/usr/bin/env python3

import json
import os
from types import SimpleNamespace
from datetime import datetime
import yaml

md_string = []
# Simple script to print a message

# Get the modification timestamp (float)
mod_timestamp = os.path.getmtime('resume.json')
# Convert the timestamp to a human-readable datetime object
mod_time_readable = datetime.fromtimestamp(mod_timestamp)
mod_time_formatted = mod_time_readable.strftime("%B %Y")

# Open and read the JSON file
with open('resume.json', 'r') as file:
   data = json.load(file, object_hook=lambda d:SimpleNamespace(**d))

# Convert keyworkds object into dictionary
allkeywords = vars(data.keywords)

profiles = []
for p in [p for p in data.profiles if p.display == True]:
    profiles.append(f"{p.mdIcon} [{p.network}]({p.url})")
profiles.append("[📄 Download PDF](./resume.pdf)")

langs = []
for lang in data.languages:
    langs.append(lang.language)

md_string.append(f"""
# {data.basics.name} - {data.basics.label}

**Contact:** {data.basics.email}  
**Location:** {data.basics.locationString}  
**Languages:** {", ".join(langs)}

{data.basics.summary}

## Work Experience
""")

jobs = []
# for job in [w for w in data.work if w.display == True]:
for job in data.work:
    job_item = []
    format_string = "%Y-%m-%d"
    date_start = datetime.strptime(job.dateStart, format_string).date().strftime("%b %Y")
    date_end = datetime.strptime(job.dateEnd, format_string).date().strftime("%b %Y") if job.dateEnd else "Present"
    via = f"<sub><small>via {job.via}</small></sub>" if job.via else ""
    startEnd = f"<small>{date_start} - {date_end}</small>"
    job_item.append(f"### {job.company} {via}")
    job_item.append("")
    job_item.append(f"<small>{date_start} - {date_end}</small>")

    if job.description and job.id == 'toptal':
        job_item.append("")
        job_item.append(job.description)

    for s in job.summary:
        job_item.append("")
        job_item.append(s)
    
    if len(job.highlights) > 0 and job.showHighlights == True:
        job_item.append("")
        for h in job.highlights:
            job_item.append(f"- {h}")

    if len(job.keywords) > 0:
        keywords = []
        _keywords = []
        for k in job.keywords:
            kw = f"<span title='{allkeywords[k].title}'>{allkeywords[k].text}</span>" if k in allkeywords else k
            _keywords.append(kw)
            keywords = f"*{", \n".join(_keywords)}*"

        job_item.append("")
        job_item.append(f"**Tools:**\n{keywords}")

    jobs.append("\n".join(job_item))

md_string.append(f"\n\n---\n\n".join(jobs))
md_string.append("")
md_string.append("---")
md_string.append("")
md_string.append(f"*Last Updated: {mod_time_formatted}*")
md_string.append("")

md_content ="\n".join(md_string)
# Print the data
print(md_content)

with open('resume_py.md', 'w', encoding='utf-8') as file:
    file.write(md_content)

with open('resume.json', 'r') as file:
   python_dict = json.load(file)

# Convert the Python dictionary to a YAML string
# default_flow_style=False ensures a human-readable, multi-line output
yaml_string = yaml.dump(python_dict, default_flow_style=False, sort_keys=False)

# Write to a YAML file
with open('resume.yaml', 'w') as f:
    f.write(yaml_string)

print("> END OF LINE.")