. .\resume-data.ps1

$sb = [System.Text.StringBuilder]::new()

$resume.Work | ForEach-Object {
    $startDate = Get-Date $_.DateStart
    $endDate = if ($_.DateEnd) { Get-Date $_.DateEnd }
    $_ | Add-Member -MemberType NoteProperty -Name "ParsedDateStart" -Value $startDate
    $_ | Add-Member -MemberType NoteProperty -Name "ParsedDateEnd" -Value $endDate
    $_ | Add-Member -MemberType NoteProperty -Name "FormattedDateStart" -Value ($startDate.ToString("MMM yyyy"))
    $_ | Add-Member -MemberType NoteProperty -Name "FormattedDateEnd" -Value (if ($endDate) { $endDate.ToString("MMM yyyy") } else { "Present" })
} | Sort-Object -Property { $_.DateEnd -eq $null}, ParsedDateEnd, ParsedDateStart -Descending

$workDescriptionTemplate = "<p class='description well'>{{Description}}</p>"
$workSummaryTemplate = "<p class='summary'>{{Summary}}</p>"
$workIndustryTemplate = "<span class='industry'>{{Value}}</span>"
$workIndustryTemplateWrapper = "<div class='industries'><h4>Industries:</h4>{{Industries}}</div>"
$workKeywordTemplate = "<abbr title='{{Title}}'>{{Value}}</abbr>"
$workKeywordTemplateWrapper = "<div class='keywords'><h4>Skills &amp; Technologies: </h4>{{Keywords}}</div>"
$workItemHighlightTemplate = "<li>{{Value}}</li>"
$workItemHighlightTemplateWrapper = "<ul>{{Highlights}}</ul>"
$workItemTemplate = @"
            <div class='job'>
                <div class='job-title'>
                 {{#if Url}}<h3><a class='company' href='{{Url}}' target='_blank' rel='noopener'>{{Company}}</a></h3>{{else}}<h3>{{Company}}</h3>{{/if}}
                    <div class='company'>
                        <span class='date'> {{DateStart}} - {{DateEnd}}</span> {{Via}}
                    </div>
                </div>
                {{Description}}
                {{Summary}}
                {{Highlights}}
                {{Industries}}
                {{Keywords}}
            </div>
"@

[void]$sb.Clear()
$workItems = $resume.Work | Sort-Object -Property { $_.DateEnd -eq $null}, ParsedDateEnd, ParsedDateStart -Descending | Foreach-Object {
    $item = $workItemTemplate
    $item = $item -replace "{{Company}}", [System.Text.RegularExpressions.Regex]::Escape($_.Company)
    $item = $item -replace "{{Url}}", [System.Text.RegularExpressions.Regex]::Escape($_.Url)
    $item = $item -replace "{{DateStart}}", [System.Text.RegularExpressions.Regex]::Escape($_.FormattedDateStart)
    $item = $item -replace "{{DateEnd}}", [System.Text.RegularExpressions.Regex]::Escape($_.FormattedDateEnd)

    if ($null -ne $_.Via -and $_.Via -ne '') {
        $item = $item -replace "{{Via}}", [System.Text.RegularExpressions.Regex]::Escape("| via $($_.Via)")
    } else {
        $item = $item -replace "{{Via}}", ""
    }

    if ($_.Description -ne $null -and $_.Description -ne '') {
        $description = $workDescriptionTemplate -replace "{{Description}}", [System.Text.RegularExpressions.Regex]::Escape($_.Description)
        $item = $item -replace "{{Description}}", $description
    } else {
        $item = $item -replace "{{Description}}", ""
    }

    if ($_.Summary.Count -gt 0) {
        $summaryText = ($_.Summary -join " ")
        $summary = $workSummaryTemplate -replace "{{Summary}}", [System.Text.RegularExpressions.Regex]::Escape($summaryText)
        $item = $item -replace "{{Summary}}", $summary
    } else {
        $item = $item -replace "{{Summary}}", ""
    }

    if ($_.Highlights.Count -gt 0) {
        $highlights = $_.Highlights | ForEach-Object { 
            $workItemHighlightTemplate -replace "{{Value}}", [System.Text.RegularExpressions.Regex]::Escape($_) 
        }
        $highlightsWrapper = $workItemHighlightTemplateWrapper -replace "{{Highlights}}", ($highlights -join "`n")
        $item = $item -replace "{{Highlights}}", $highlightsWrapper
    } else {
        $item = $item -replace "{{Highlights}}", ""
    }

    if ($_.Industries.Count -gt 0) {
        $industries = $_.Industries | Sort-Object | ForEach-Object { 
            $workIndustryTemplate -replace "{{Value}}", [System.Text.RegularExpressions.Regex]::Escape($_) 
        }
        $industriesWrapper = $workIndustryTemplateWrapper -replace "{{Industries}}", ($industries -join ",`n")
        $item = $item -replace "{{Industries}}", $industriesWrapper
    } else {
        $item = $item -replace "{{Industries}}", ""
    }

    if ($_.Keywords.Count -gt 0) {
        $keywords = $_.Keywords | Sort-Object | ForEach-Object { 
            $workKeywordTemplate -replace "{{Value}}", [System.Text.RegularExpressions.Regex]::Escape($_) -replace "{{Title}}", [System.Text.RegularExpressions.Regex]::Escape($resume.Keywords[$_])
        }
        $keywordsWrapper = $workKeywordTemplateWrapper -replace "{{Keywords}}", ($keywords -join ",`n")
        $item = $item -replace "{{Keywords}}", $keywordsWrapper
    } else {
        $item = $item -replace "{{Keywords}}", ""
    }
}

$workItems = $resume.Work | Sort-Object -Property { $_.DateEnd -eq $null}, ParsedDateEnd, ParsedDateStart -Descending | ForEach-Object {
    $dateStart = Get-Date $_.DateStart -Format "MMM yyyy"
    $dateEnd = if ($_.DateEnd -eq $null) { "Present" } else { (Get-Date $_.DateEnd -Format "MMM yyyy") }
    $highlights = $_.Highlights | ForEach-Object {  "<li>$($_)</li>" }
    # $keywords = $_.Keywords | Sort-Object | ForEach-Object { "<span class='keyword' title='$($resume.Keywords[$_])'>$_</span>" }
    $keywords = $_.Keywords | Sort-Object | ForEach-Object { "<abbr title='$($resume.Keywords[$_])'>$_</abbr>" }
    $industries = $_.Industries | Sort-Object | ForEach-Object { "<span class='industry' title='$($_)'>$_</span>"}
@"
            <div class='job'>
                <div class='job-title'>
                 $(@("<h3>$($_.Name)</h3>", "<h3><a class='company' href='$($_.Url)' target='_blank' rel='noopener'>$($_.Name)</a></h3>")[$_.Url -ne ""])
                    <div class='company'>
                        <span class='date'><span class='date'> $($dateStart) - $($dateEnd)</span> $(if ($_.Via) { " | via $($_.Via)" } else { "" })
                    </div>
                </div>
                $(if ($_.Description -ne $null -and $_.Description -ne '') { @"
<p class='description well'>
                    $($_.Description)
                </p>
"@ })
                $(if ($_.Summary.Count -gt 0) { @"
<p class='summary'>
                    $($_.Summary -join " ")
                </p>
"@ })
                <ul>
                    $($highlights -join "`n                    ")
                </ul>
                $(if ($_.Industries.Count -gt 0)  { 
@"
<div class='industries'>
                    <h4>Industries:</h4>
                    $($industries -join ",`n                    ")
                </div>
"@
                })
                $(if ($_.Keywords.Count -gt 0) { 
@"
<div class='keywords'>
                    <h4>Skills &amp; Technologies: </h4>
                    $($keywords -join ",`n                    ")
                </div>
"@
                })
            </div>
"@
} | Out-String

$certifications = $resume.Certifications | ForEach-Object { 
    $date = Get-Date -Date $_.Date -Format 'yyyy'
    "<li>$($_.Issuer) - $($_.Name) - ($($date))</li>" 
}

$HTML = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$($resume.Basics.Name) - Resume</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; line-height: 1.6; box-sizing: content-box; }
        h1, h2, h3 { color: #333; }
        h2 { border-bottom: solid 1px #333; }
        h3 { margin-block-start: 1em; margin-block-end: 0em; }
        h4 { margin-block-end: 0.5em; }
        a { color: blue; text-decoration: none; }
        ul { list-style-type: disc; margin-left: 10px; }
        li { margin-left: 0px !important; }
        .section { margin-bottom: 20px; }
        .job, .education { margin-bottom: 10px; }
        .job-title { display: flex; align-items: baseline; gap: 10px; }
        .company { font-style: italic; }
        .date { color: #666; }
        .job .description, .job .industries, .job .keywords { font-size: 0.9em; color: #555; }
        
        .well {
            min-height: 20px;
            padding: 12px;
            margin-bottom: 20px;
            background-color: #f5f5f5;
            border: 1px solid #e3e3e3;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
        }
        .container {
            padding-right: 15px;
            padding-left: 15px;
            margin-right: auto;
            margin-left: auto;
        }
        @media (min-width: 768px) {
            .container { width: 750px; }
        }
        @media (min-width: 992px) {
            .container { width: 970px; }
        }
        @media (min-width: 1200px) {
            .container { width: 1170px; }
        }
            abbr {
  font-style: italic;
  color: #555;
  text-decoration: none;
}
    </style>
</head>
<body>
<div class="container">
    <h1>$($resume.Basics.Name) - $($resume.Basics.Label)</h1>
    <p>
        Email: <a href="mailto:$($resume.Basics.Email)">$($resume.Basics.Email)</a> 
        | Phone: $($resume.Basics.Phone) 
        | Location: $($resume.Basics.Location.City), $($resume.Basics.Location.CountryCode)
        | Timezone: $($resume.Basics.Timezone)
    </p>

    <div class="section">
        <h2>Summary</h2>
        <p>$($resume.Basics.Summary)</p>

        <p class="languages"><b>Languages:</b> $(($resume.Languages | ForEach-Object { "$($_.Language)" }) -join ", ")</p>
    </div>

    <div class="section">
        <h2>Experience</h2>
        ##EXPERIENCE##
$($workItems -join "`n")
    </div>

    <div class="section">
        <h2>Certifications</h2>
        <ul>
            $($certifications -join "`n            ")
        </ul>
    </div>
</div>
</body>
</html>
"@

$HTML | Out-File -FilePath "resume.output.html" -Encoding UTF8
Write-Host "Resume HTML generated: resume.html"
