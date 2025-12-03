. .\resume-data.ps1

$sb = New-Object System.Text.StringBuilder

$profiles = ($resume.Profiles.Where({ $_.Display -ne $false }) | ForEach-Object {
    "**$(@($_.MDIcon, $_.Network)[!$_.MDIcon])** [$($_.Network)]($($_.Url))"
}) -join " "
$pdfDownload = "| [📄 Download PDF](./resume.pdf) |"

[void]$sb.AppendLine("# $($resume.Basics.Name) - $($resume.Basics.Label)")
[void]$sb.AppendLine('')
[void]$sb.AppendLine("$profiles $pdfDownload")
[void]$sb.AppendLine('')
[void]$sb.AppendLine($resume.Basics.Summary)
[void]$sb.AppendLine('')

if ($resume.Languages) {
    $languages = ($resume.Languages | ForEach-Object { "$($_.Language)" }) -join ", "
    [void]$sb.AppendLine("**Languages:** $languages")
}

[void]$sb.AppendLine('')
[void]$sb.AppendLine('## Work Experience')
[void]$sb.AppendLine('')

$index = 0
$workItems = $resume.work.Where({ $_.Display -eq $true })

foreach ($job in $workItems) {
    $dateStart = Get-Date -Date $job.DateStart -Format "MMM yyyy"
    $dateEnd = if ($job.DateEnd) { Get-Date -Date $job.DateEnd -Format "MMM yyyy" } else { "Present" }
    $via = @("", "<sub><small><i>via: $($job.Via)</i></small></sub>")[$job.Via -ne '']

    [void]$sb.AppendLine("### <small>$($dateStart) - $($dateEnd)</small> | [$($job.Company)]($($job.url)) $($via)")

    if ($job.HasDescription() -and $job.Id -eq "toptal") {
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine($job.Description)
        [void]$sb.AppendLine('')
    }

    if ($job.Summary) {
        [void]$sb.AppendLine('')
        [void]$sb.AppendLine($job.Summary)
    }
    
    if ($job.highlights -and $job.ShowHighlights) {
        [void]$sb.AppendLine('')
        foreach ($highlight in $job.Highlights) {
            [void]$sb.AppendLine("- $highlight")
        }
        [void]$sb.AppendLine('')
    }
    
    if ($job.keywords) {
        $keywords = ($job.keywords | Sort-Object | ForEach-Object { 
                $kw = $resume.Keywords[$_] ?? [Keyword]@{
                    Text  = $_
                    Title = $_
                }
                "<span title='$($kw.Title)'>*$($kw.Text)*</span>"
            }) -join ", "
        [void]$sb.AppendLine()
        [void]$sb.AppendLine("**Technologies & Skills:** $keywords")
        [void]$sb.AppendLine()
    }

    if ($index -lt ($workItems.Count - 1)) {
        [void]$sb.AppendLine('---').AppendLine()
    }
    $index++
}

# $allKeywords = $resume.Work | ForEach-Object { $_.Keywords } | Sort-Object -Unique

# [void]$sb.AppendLine('')
# [void]$sb.AppendLine('---')
# [void]$sb.AppendLine('')
# [void]$sb.AppendLine('**All Technologies & Skills Used:**')
# [void]$sb.AppendLine('')
# [void]$sb.AppendLine('```')
# [void]$sb.AppendLine(($allKeywords) -join "`n")
# [void]$sb.AppendLine('```')

# Get-Date -Date (Get-Item $PSCommandPath | Select-Object -ExpandProperty LastWriteTime) -Format u
$lastWriteTime = Get-Date -Date (Get-Item .\resume-data.ps1).LastWriteTime -Format "MMM dd, yyyy"
[void]$sb.AppendLine("---")
[void]$sb.AppendLine()
[void]$sb.AppendLine("*Last Updated: $($lastWriteTime)*")

$sb.ToString() | Set-Content '.\resume.md' -Force -Encoding UTF8
Copy-Item '.\resume.md' '.\readme.md' -Force
