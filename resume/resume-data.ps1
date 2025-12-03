class Location {
    [string]$City
    [string]$CountryCode
    [string]$CountryName
    [string]$Region
    [string]$RegionName
}

class Profile {
    [string]$Network
    [string]$Username
    [string]$Url
    [string]$MDIcon
    [bool]$Display
}

class Basics {
    [string]$Name
    [string]$Label
    [string]$Email
    [string]$Phone
    [string]$Website
    [string]$Timezone
    [string]$Summary
    [string]$LocationString
    [Location]$Location
}

class Language {
    [string]$Language
    [string]$Fluency

    [string]ToString() {
        return "$($this.Language)"
    }
}

class Work {
    [string]$Id
    [bool]$Current
    [bool]$Display = $true
    [string]$Via
    [string]$Company
    [string]$Description
    [string]$DateStart
    [string]$DateEnd
    [string[]]$Location
    [string]$Position
    [string]$Url
    [string[]]$Summary
    [string[]]$Highlights
    [string[]]$Industries
    [string[]]$Keywords

    [datetime]$ParsedDateStart
    [datetime]$ParsedDateEnd
    [string]$FormattedDateStart
    [string]$FormattedDateEnd
    [bool]$ShowHighlights = $true

    [bool]HasDescription() {
        return $this.Description -ne $null -and $this.Description.Length -gt 0
    }

    Work() {
    }

    Work([psobject]$data) {
        $this.Id = $data.Id
        $this.Current = $data.Current
        $this.Display = $data.Display ?? $true
        $this.Via = $data.Via
        $this.Company = $data.Company
        $this.Description = $data.Description
        $this.DateStart = $data.DateStart
        $this.DateEnd = $data.DateEnd
        $this.Location = $data.Location
        $this.Position = $data.Position
        $this.Url = $data.Url
        $this.Summary = $data.Summary
        $this.Highlights = $data.Highlights
        $this.Industries = $data.Industries
        $this.Keywords = $data.Keywords

        if ($this.DateStart) {
            $this.ParsedDateStart = Get-Date $this.DateStart
            $this.FormattedDateStart = $this.ParsedDateStart.ToString("MMM yyyy")
        }

        if ($this.DateEnd) {
            $this.ParsedDateEnd = Get-Date $this.DateEnd
            $this.FormattedDateEnd = $this.ParsedDateEnd.ToString("MMM yyyy")
        }
        else {
            if ($this.Current) {
                $this.FormattedDateEnd = "Present"
            }
        }
    }
}

class Certification {
    [string]$Name
    [string]$Date
    [string]$Issuer
    [string]$Summary
}

class Metatags {
    [string]$Title
    [string]$Description
    [string]$SiteName
    [string]$Url
    [string]$Type
}

class Keyword {
    [string]$Text
    [string]$Title
}

class Resume {
    [datetime]$LastUpdated
    [Basics]$Basics
    [Language[]]$Languages
    [Profile[]]$Profiles
    [Work[]]$Work
    [Certification[]]$Certifications
    [Metatags]$Metatags
    [ordered]$Keywords
    [hashtable]$Meta
}

$resume = [Resume]@{
    # LastUpdated    = Get-Date -Date (Get-Item $PSCommandPath | Select-Object -ExpandProperty LastWriteTime) -Format u
    LastUpdated = Get-Date -Date "2025-12-03 10:14:18Z"
    Basics         = [Basics]@{
        Name           = "Pablo López"
        Label          = "Software Developer"
        Email          = "pablo@pablolopez.dev"
        Phone          = "+52 66250-89761"
        Website        = "https://resume.pablolopez.dev"
        Timezone       = "(UTC-07:00) America - Hermosillo"
        Summary        = "I have great adaptability, the ability to work collaboratively with cross-functional teams, learn new skills quickly and am always interested in new challenges. I possess good communication skills and can tackle problems and situations with sensitivity and proactively. I consistently contribute to the achievement of both team and personal goals, don't hesitate to ask what I don't know, do the research and get things done."
        LocationString = "Hermosillo, Sonora, Mexico"
        Location       = [Location]@{
            City        = "Hermosillo"
            CountryCode = "MX"
            CountryName = "Mexico"
            Region      = "SON"
            RegionName  = "Sonora"
        }
    }
    Languages      = @(
        [Language]@{
            Language = "Spanish"
            Fluency  = "Native"
        },
        [Language]@{
            Language = "English"
            Fluency  = "Professional"
        }
    )
    Profiles       = @(
        [Profile]@{
            Network  = "Email"
            Username = "pablo@pablolopez.dev"
            Url      = "mailto:pablo+contact@pablolopez.dev"
            MDIcon   = "📧"
            Display  = $true
        },
        [Profile]@{
            Network  = "Website"
            Username = "resume.pablolopez.dev"
            Url      = "https://resume.pablolopez.dev"
            MDIcon   = "🌐"
            Display  = $true
        },
        [Profile]@{
            Network  = "LinkedIn"
            Username = "linkedin.com/in/jplopezg"
            Url      = "https://www.linkedin.com/in/jplopezg/"
            MDIcon   = "🏢"
            Display  = $true
        },
        [Profile]@{
            Network  = "Github"
            Username = "github.com/jnpbl79"
            Url      = "https://github.com/jnpbl79"
            MDIcon   = "🐙"
            Display  = $true
        },
        [Profile]@{
            Network  = "Toptal"
            Username = "www.toptal.com/resume/juan-pablo-lopez-garcia"
            Url      = "https://www.toptal.com/resume/juan-pablo-lopez-garcia"
            Display  = $false
        }
    )
    Work           = @(
        [Work]@{
            Id          = "toptal"
            Current     = $true
            Via         = ""
            Company     = "Toptal"
            Description = "Toptal is a global, remote-first network that connects businesses with vetted freelance professionals, primarily in tech, design, and business fields like software engineering, product management, and project management."
            DateStart   = "2012-11-01"
            DateEnd     = $null
            Location    = @("Remote")
            Position    = "Software Developer"
            Url         = "https://www.toptal.com"
            Summary     = @()
            Highlights  = @()
            Keywords    = @()
        },
        [Work]@{
            Id          = "pgfx"
            Current     = $true
            Via         = "Toptal"
            Company     = "PokerGFX LLC"
            Description = "PokerGFX is the software platform used to generate real-time poker graphics and statistics for live poker broadcasts. It is a Windows-based software suite designed to work seamlessly with PokerGFX RFID hardware. It automates camera switching and overlays animated graphics on live streams."
            DateStart   = "2024-12-02"
            DateEnd     = "2025-08-11"
            Location    = @("Remote")
            Position    = "FullStack .NET Developer"
            Url         = "https://www.pokergfx.io"
            Summary     = @()
            Highlights  = @(
                "Migrated projects from .NET 4.5 to .NET 9, enabling access to the latest language features and improving runtime performance.",
                "Developed a configuration preset feature, allowing users to save, load, and apply over 50 customizable tournament and broadcast settings.",
                "Optimized startup by deferring non-critical component initialization to background threads, reducing perceived load time.",
                
                "Consolidated all PokerGFX applications into a single solution structure, improving maintainability and cross-project integration.",
                "Refactored the licensing system by separating license logic into focused classes, improving maintainability, increasing testability by introducing license test classes, and simplifying feature access control by exposing clear properties.",
                "Developed a WPF application to read, write and validate licences to KEYLOK hardware, facilitating offline license management for users.",
                "Automated the end-to-end build, signing, and publishing process for all PokerGFX projects, reducing manual effort and human error.",
                "Added support for continuous integration and deployment using GitLab runners."
            )
            Industries  = @(
                "Sports",
                "Video Streaming"
            )
            Keywords    = @(
                "advinstaller",
                "apiintegration",
                "awss3",
                "c#",
                "dotnet",
                "dotnetfx",
                "git",
                "gitlabrunners",
                "keylok",
                "mssql",
                "mvvm",
                # "netreactor",
                # "obfuscation",
                "pwsh",
                "winforms",
                "wpf",
                "wpfui",
                "xaml"
            )
        },
        [Work]@{
            Id          = "cgi"
            Current     = $true
            Via         = "Toptal"
            Company     = "CGi, LLC"
            Description = "CGi is a full-service association and events management company."
            DateStart   = "2024-07-19"
            DateEnd     = "2025-02-01"
            Location    = @("Remote")
            Position    = "FullStack .NET Developer"
            Url         = "https://www.toptal.com"
            Summary     = @()
            Highlights  = @(
                "Fixed bugs around the website that were reported by users.",
                "Simplified code around the website and centralized database access while fixing bugs.",
                "Made web page updates, replacing text, images, and updating layouts."
            )
            Industries  = @(
                "Business Services", 
                "Research & Development"
            )
            Keywords    = @(
                "aspnet",
                "dotnetfx",
                "git",
                "mssql",
                "mysql",
                "vbnet",
                "webforms"
            )
        },
        [Work]@{
            Id          = "alteryx"
            Current     = $false
            Via         = "Toptal"
            Company     = "Alteryx"
            Description = "Alteryx is Self-Service Analytics, Data Science & Process Automation software."
            DateStart   = "2020-08-01"
            DateEnd     = "2024-01-01"
            Location    = @("Broomfield, CO, US", "Remote")
            Position    = "Accessibility Software Engineer"
            Url         = "https://alteryx.com"
            Summary     = @(
                "Implemented accessibility guidelines and screen reader support in flagship desktop and cloud products using Windows Forms and React, going beyond mere compliance by refactoring code and redesigning interfaces for improved usability. Achieved innovation by introducing keyboard navigation, manipulation, and screen reader support to workflow diagrams, a feature previously non-existent on the market."
            )
            Highlights  = @(
                "Added keyboard navigation, manipulation and screen reader support to workflow diagram components which at the time no one else had and did not exist on the market using C# and Windows Forms.",
                "Updated, refactored and developed custom accessibility objects for in-house and third-party Windows Forms components to enable screen reader support and keyboard navigation improving usability and overall user experience using C# and Windows Forms.",
                "Updated, refactored and redesigned a variety of controls and user interfaces to enable accessibility features which included form inputs, multi-level menus, dialogs, tree views, datagrids, toolbars, workflow diagrams, split views, tool selectors and others improving usability and overall user experience.",
                "Updated and refactored custom components to better integrate accessibility features and keyboard navigation using Javascript and React.",
                "Updated and created new user interface automated tests using C# and White Framework."
            )
            Industries  = @(
                "Data Analytics",
                "Business Intelligence (BI) Software",
                "Software"
            )
            Keywords    = @(
                "a11y",
                "c#",
                "cef",
                "dotnetfx",
                "git",
                "js",
                "mindfusion",
                "mui",
                "react",
                "Screen Readers",
                "syncfusion",
                "telerik",
                "uiautomation",
                "wcag",
                "white",
                "winforms"
            )
        },
        [Work]@{
            Id             = "fremantle"
            Current        = $false
            Via            = ""
            Company        = "Fremantle Productions"
            Description    = "Fremantle is a world leader in creating, producing and distributing across entertainment, drama, film and documentary content."
            DateStart      = "2021-04-01"
            DateEnd        = "2021-05-01"
            Location       = @("")
            Position       = "Software Developer"
            Url            = "https://fremantle.com/"
            Summary        = @(
                "Designed and developed a web application enabling Show Producers to work remotely, maintaining seamless access to live camera streams during TV show broadcasts, despite COVID-19 restrictions."
            )
            Highlights     = @(
                "Developed millicast Javascript API client to use on website and display video streams.",
                "Developed user and role management web interface using ASP.NET Core Identity."
            )
            Industries     = @(
                "Media Production",
                "Entertainment",
                "Film & Television"
            )
            Keywords       = @(
                "apiintegration",
                "aspnetcore",
                # "aspnetidentity",
                "awsec2",
                # "bootstrap",
                "c#",
                # "css",
                "dolbyio",
                "dotnet",
                # "efcore",
                "git",
                "js",
                "mariadb",
                "millicast",
                "nswag",
                "openapi",
                "razor",
                "webapi"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "reebok"
            Current        = $false
            Via            = ""
            Company        = "Reebok CrossFit Games 2020"
            Description    = "The Reebok CrossFit Games website, now known as the CrossFit Games, is the official online platform for the `"ultimate proving grounds for the Fittest on Earth™,`" where top athletes compete in the annual CrossFit Games. It provides information on the CrossFit Open, a global event where anyone can compete, and offers results, schedules, and details on upcoming events for individuals, teams, and age-group athletes."
            DateStart      = "2020-07-01"
            DateEnd        = "2020-08-01"
            Location       = @("")
            Position       = "Software Developer"
            Url            = "https://games.crossfit.com"
            Summary        = @(
                "Developed web application tailored for mobile devices, enabling athletes to seamlessly stream or upload their trial and competition videos for review by judges. This platform facilitated remote interaction between athletes and judges, thereby overcoming geographical constraints imposed by the COVID-19  pandemic"
            )
            Highlights     = @(
                "Developed a web application for streaming and uploading trial and competition videos for judges to review using ASP.NET Core Razor Pages.",
                "Transcoded user uploaded videos to more compatible format using FFmpeg.",
                "Developed user and role management web interface using ASP.NET Core Identity."
            )
            Industries     = @(
                "Sports Teams & Leagues",
                "Sports"
            )
            Keywords       = @(
                "aspnetcore",
                # "aspnetidentity",
                "awsec2",
                "awss3",
                # "bootstrap",
                "c#",
                # "css",
                "dotnetcore",
                # "efcore",
                "ffmpeg",
                "git",
                "js",
                "mariadb",
                "razor"
            )
            ShowHighlights = $false
        },
        [Work]@{
            # Id          = "advancedaudiosystems"
            Id          = "funeralvue"
            Current     = $false
            Via         = "Toptal"
            # Company        = "Advanced Audio Systems"
            Company     = "FuneralVue"
            Description = "FuneralVue offers recording and webcasting services to funeral homes around the World."
            DateStart   = "2020-03-01"
            DateEnd     = "2020-08-01"
            Location    = @("Cincinnati, Ohio, US", "Remote")
            Position    = "Software Developer"
            Url         = "https://funefalvue.com"
            Summary     = @(
                "Developed and updated various desktop and web applications to improve customer service, streamline business operations, and automate time-consuming tasks, enhancing overall efficiency and productivity for the organization."
            )
            Highlights  = @(
                "Updated the client's primary Windows Forms based application, incorporating their new branding and adding innovative features.",
                "Updates and enhancements to the company's management website.",
                "Created a checkout page with customizable DVD packaging options and integrated Stripe payment processing.",
                "Designed and developed a mobile web app allowing users to stream live events directly from their mobile devices, enhancing customer experience by reducing wait times and enabling on-the-go access to the company's services.",
                "Developed an application to automate DVD ISO image creation from MP4 videos, utilizing Windows Services for efficient execution of lengthy tasks, and paired with a WPF desktop app for service management and notification display."
            )
            Industries  = @(
                "Funeral Homes & Funeral Related Services",
                "Media and content production",
                "Audio & Video Streaming"
            )
            Keywords    = @(
                "awsec2",
                "awss3",
                # "bootstrap",
                "c#",
                "cakephp",
                "docker",
                "dotnetfx",
                "dvdiso",
                "ffmpeg",
                "git",
                "js",
                "larix",
                "mysql",
                "pwsh",
                "react",
                # "reactrouter",
                # "redux",
                "rtmp",
                "stripe",
                "vue",
                "webapi",
                "winforms",
                "winservices",
                "wowza",
                "wpf",
                "xaml"
            )
        },
        [Work]@{
            Id             = "evolutionsoftware"
            Current        = $false
            Via            = "Toptal"
            Company        = "Evolution Software"
            Description    = "Evolution Software has a web application to visually create web applications which with little to no developer intervention can create custom modules for different customers’ needs."
            DateStart      = "2019-03-01"
            DateEnd        = "2020-01-01"
            Location       = @("Cape Town, South Africa", "Remote")
            Position       = "Software Developer"
            Url            = "https://evolutionsoftware.co.za/"
            Summary        = @(
                "Implemented Entity Framework to streamline database interactions, automating repetitive tasks and reducing code complexity. Optimized database queries and stored procedures for faster results. Developed modules using a custom framework built on top of ASP.NET. Exposed frequently used functionality via Web Services. Replaced server-side controls with client-side rendering and asynchronous requests, enhancing performance and user experience."
            )
            Highlights     = @(
                "Created modules using their custom framework built on top of ASP.NET for specific clients.",
                "Added an Entity Framework data layer replicating and automating actions taken by their custom data access layer which works with ADO.NET.",
                "Added Web API to reduce full-page postbacks in several commonly used pages and KnockoutJS for client side datagrid processing which greatly improved overall performance and user experience.",
                "Edited database queries, columns and stored procedures to improve performance and get faster results."
            )
            Industries     = @(
                "Custom Software & IT Services"
            )
            Keywords       = @(
                "dotnetfx",
                # "adonet",
                "aspnet",
                "c#",
                # "ef",
                "git",
                "js",
                "knockout",
                "mssql",
                "webforms",
                "webservices"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id          = "mdlive"
            Current     = $false
            Display     = $false
            Via         = "Nearsoft"
            Company     = "MDLive, Inc."
            Description = "MDLIVE is a telehealth provider which provides patients, health plans, health systems and self-insured employers online access to board-certified doctors, pediatricians and licensed therapists."
            DateStart   = "2015-09-01"
            DateEnd     = "2019-08-01"
            Location    = @("Miramar, FL, US", "Remote")
            Position    = "Software Developer"
            Url         = "https://www.mdlive.com"
            Summary     = @(
                "I was involved and worked alongside product design, UX, DevOps and other development teams to build, integrate and deploy a WebRTC conferencing solution composed of several back and front end services and components."
            )
            Highlights  = @(
                "WebRTC solution with audio recording composed of signaling server, Javascript and C# clients, Azure Storage, Queues and Functions.",
                "Ruby gem to map Surecript API request and response messages between JSON and XML.",
                "Added Office 365 authentication to UWP application.",
                "Worked with iOS and Android development teams to help with integration of video conferencing application",
                "Worked with DevOps team to help with infrastructure provisioning and deployment of server-side applications on Azure.",
                "Worked with offshore team to help debug and deploy a payment gateway written in ASP.NET."
            )
            Industries  = @(
                "Healthcare Software",
                "Mental Health & Rehabilitation Facilities",
                "Telehealth Services"
            )
            Keywords    = @(
                "aspnet",
                # "azure",
                "azure_queues",
                "azure_storage",
                "azure_functions",
                "c#",
                "docker",
                "dockerwindows",
                "dotnetfx",
                "ffmpeg",
                "frozenmountain",
                "git",
                "icelink",
                "js",
                "mssql",
                "mvc",
                "objectivec",
                "pwsh",
                "react",
                "ror",
                # "ruby",
                "surescripts",
                "webapi",
                "webrtc",
                "Websync",
                "xcode"
            )
        },
        [Work]@{
            Id          = "nearsoft-mdlive"
            Current     = $false
            Via         = ""
            Company     = "Nearsoft"
            Description = "Nearsoft a US-based nearshore software engineering and product development firm that specializes in software development outsourcing and building dedicated engineering teams for software product companies."
            DateStart   = "2015-09-01"
            DateEnd     = "2019-08-01"
            Location    = @("Hermosillo, SON, MX")
            Position    = "Software Developer"
            Url         = "https://www.encora.com/news/nearsoft-is-now-encora"
            Summary     = @(
                "As part of the [MDLive Inc](https://www.mdlive.com) team, I was involved and worked alongside product design, UX, DevOps and other development teams to build, integrate and deploy a WebRTC conferencing solution composed of several back and front end services and components."
            )
            Highlights  = @(
                "WebRTC solution with audio recording composed of signaling server, Javascript and C# clients, Azure Storage, Queues and Functions.",
                "Ruby gem to map Surecript API request and response messages between JSON and XML.",
                "Added Office 365 authentication to UWP application.",
                "Worked with iOS and Android development teams to help with integration of video conferencing application",
                "Worked with DevOps team to help with infrastructure provisioning and deployment of server-side applications on Azure.",
                "Worked with offshore team to help debug and deploy a payment gateway written in ASP.NET."
            )
            Industries  = @(
                "Healthcare Software",
                "Mental Health & Rehabilitation Facilities",
                "Telehealth Services"
            )
            Keywords    = @(
                "aspnet",
                # "azure",
                "azure_queues",
                "azure_storage",
                "azure_functions",
                "c#",
                "docker",
                "dockerwindows",
                "dotnetfx",
                "ffmpeg",
                "frozenmountain",
                "git",
                "icelink",
                "js",
                "mssql",
                "mvc",
                # "objectivec",
                "pwsh",
                "react",
                "ror",
                # "ruby",
                "surescripts",
                "webapi",
                "webrtc",
                "Websync"
                # "xcode"
            )
        },
        [Work]@{
            Id             = "d4"
            Current        = $false
            Via            = "Toptal"
            Company        = "D4 Software"
            Description    = "Software, Big Data & Analytics."
            DateStart      = "2015-04-01"
            DateEnd        = "2015-06-01"
            Location       = @("Birmingham, UK", "Remote")
            Position       = "Software Developer"
            Url            = "http://weared4.com"
            Summary        = @(
                "Worked on various development projects for ASP.NET MVC websites, focusing on enhancing user experience, email sending and tracking features."
            )
            Highlights     = @(
                "Worked with Sass, Twitter Bloodhound, and Entity framework migrations.",
                "Created background tasks for sending emails on ASP.NET websites.",
                "Implemented email view tracking."
            )
            Industries     = @(
                "Custom Software & IT Services"
            )
            Keywords       = @(
                "aspnet",
                # "aspnetmvc",
                # "bootstrap",
                "c#",
                # "css",
                "dotnetfx",
                # "ef",
                "git",
                "jquery",
                "js",
                "knockout",
                "mssql",
                "mvc",
                # "sass",
                "webapi"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "arex"
            Current        = $false
            Via            = "Toptal"
            Company        = "arex Rxchange GmbH"
            Description    = "Rxchange is an online marketplace for wholesale dealers located in the EU, trading EU or EU-registered medicinal products."
            DateStart      = "2014-10-01"
            DateEnd        = "2015-02-01"
            Location       = @("Munich, DE", "Remote")
            Position       = "Software Developer"
            Url            = "https://www.rxchange.co.uk"
            Summary        = @(
                "Worked on ASP.NET MVC components to improve operations within an online E-Commerce Pharmaceutical B2B marketplace for wholesale dealers in the EU."
            )
            Highlights     = @(
                "Created user controls to ease access to information across orders.",
                "Updated components to view and handle price change requests.",
                "Created feature to keep track and process acceptance states for batches in orders.",
                "Created a new page to view and handle acceptance state for batches in orders."
            )
            Industries     = @(
                "E-Commerce",
                "Pharmaceuticals"
            )
            Keywords       = @(
                "aspnet",
                # "bootstrap",
                "c#",
                "dotnetfx",
                # "ef",
                "git",
                "jquery",
                "js",
                "mssql",
                "mvc",
                "webapi"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "amc"
            Current        = $false
            Via            = "Toptal"
            Company        = "American Mortgage Consultants"
            Description    = "SitusAMC is the leading independent solutions provider to the real estate finance industry, powering opportunity across the lifecycle of commercial and residential real estate lending and investing."
            DateStart      = "2013-01-01"
            DateEnd        = "2014-09-01"
            Location       = @("Tampa, FL, US", "Remote")
            Position       = "Software Developer"
            Url            = "https://www.situsamc.com"
            Summary        = @(
                # "Designed and developed solutions and components to enhance claims processing efficiency and streamline due diligence activities, thereby optimizing business operations.",
                "I developed and enhanced several components within a loan management system, including a rules engine for applying tests to loans and a stipulations manager, both leveraging ASP.NET technologies and KnockoutJS for responsive client-side interactions. I also implemented a claims review module and contributed migrating Classic ASP web applications written with VBScript to ASP.NET Web Forms with C# and data access code migration from ADO.NET to .netTiers. Additionally, I refactored multiple ASP.NET Web Forms to boost performance and optimize resource usage across the application."
            )
            Highlights     = @(
                "ASP/VBScript (Classic ASP) migration to ASP.NET Web Forms and C#.",
                "ADO and ADO.NET data access code migration to .netTiers and LINQ to SQL.",
                "Simple rules engine tool to apply tests to loans using ASP.NET MVC, Web API and KnockoutJS.",
                "Component to manage Loan Stipulations using ASP.NET Web Services and KnockoutJS.",
                "Component for reviewing Claims.",
                
                "Updated and refactored several ASP.NET Web Forms to improve performance and resource handling."
            )
            Industries     = @(
                "Custom Software & IT Services",
                "Financial Institutions",
                "Insurance"
            )
            Keywords       = @(
                # "ado",
                # "adonet",
                "aspnet",
                # "bootstrap",
                "c#",
                "dotnetfx",
                "jquery",
                "js",
                "knockout",
                "mssql",
                "nettiers",
                "tfs",
                "webforms",
                "webservices"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "serpicodev"
            Current        = $false
            Via            = ""
            Company        = "Serpico DEV"
            Description    = "SerpicoDEV (now Founders Workshop) was a global software development firm, headquartered in Scottsdale, AZ, that focused on serving entrepreneurs, startups, and small businesses by transforming ideas into market-ready, solutions. The company provided services such as software development, system integration, and legacy system migration, leveraging business strategy, design and product development to deliver human-centered solutions and drive client ventures forward."
            DateStart      = "2011-10-01"
            DateEnd        = "2013-01-01"
            Location       = @("Phoenix, AZ, US", "Remote")
            Position       = "Software Developer"
            Url            = ""
            Summary        = @(
                "Platform for Career Tutors to manage and review professional profiles created by College Students.  Collaborated with the AppointmentPlus development team to create a Web API and Outlook Plugin."
            )
            Highlights     = @(
                "Web application to help Career Tutors keep track and review professional profiles created by College Students on LinkedIn and provide assistance with job and career placements.",
                "Integrated Flypaper presentations into websites using Javascript API clients and Back-end database connectivity.",
                "Worked with the AppointmentPlus development team to create a Web API and Outlook Plugin for synchronizing calendar events with AppointmentPlus appointments and contacts."
            )
            Industries     = @(
                "Custom Software & IT Services"
            )
            Keywords       = @(
                "aspnet",
                # "bootstrap",
                "c#",
                "cakephp",
                "dotnet",
                # "ef",
                "git",
                "jquery",
                "jqueryui",
                "js",
                "kendoui",
                "mssql",
                "mvc",
                "mysql",
                "webapi"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "hildebrando"
            Current        = $false
            Via            = "Hildebrando"
            Company        = "Esurance"
            Description    = "Esurance is an online insurance provider, now a subsidiary of Allstate, that sells direct-to-consumer auto, home, renters, and motorcycle insurance through its website and mobile app."
            DateStart      = "2011-03-01"
            DateEnd        = "2011-10-01"
            Location       = @("Guadalajara, JAL, MX")
            Position       = "Software Developer"
            Url            = "https://www.esurance.com"
            Summary        = @(
                "Migrated multiple sections of an existing web application used for insurance claim management from ASP to ASP.NET. Additionally, created new components to support additional features."
            )
            Highlights     = @(

            )
            Industries     = @(
                "Custom Software & IT Services",
                "Insurance"
            )
            Keywords       = @(
                "dotnetfx",
                # "adonet",
                # "ado",
                "aspnet",
                "asp",
                "c#",
                "devexpress",
                "jquery",
                "js",
                "linqtosql",
                "mssql",
                "tfs",
                "vbscript",
                "webforms",
                "webservices"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "nearsoft-yotta"
            Current        = $false
            Via            = ""
            Company        = "Nearsoft"
            Description    = "Nearsoft is a software development company that builds high-quality software products for startups and established businesses."
            DateStart      = "2010-07-01"
            DateEnd        = "2011-03-01"
            Location       = @("Hermosillo, SON, MX")
            Position       = "Software Developer"
            Url            = "https://www.encora.com/news/nearsoft-is-now-encora"
            Summary        = @(
                "As part of the HarvestMark engineering team, I Developed various components for a traceability software that tracks the origin and freshness of food."
            )
            Highlights     = @(

            )
            Industries     = @(
                "Custom Software & IT Services",
                "Food Safety",
                "Foodtech"
            )
            Keywords       = @(
                # "adonet",
                "aspnet",
                "c#",
                "dotnetfx",
                "dotnetce",
                "mssql",
                "mssqlce",
                "mssqlxml",
                "tfs",
                "wcf",
                "webforms",
                "webservices",
                "winforms",
                "winservices"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "tiempo"
            Current        = $false
            Via            = ""
            Company        = "Tiempo Development"
            Description    = "Tiempo Development is a software development company offering nearshore services, providing software development, deployment, and support to clients in North America, with development centers in Guadalajara, Hermosillo, and Monterrey, Mexico."
            DateStart      = "2007-11-01"
            DateEnd        = "2010-01-01"
            Location       = @("Hermosillo, SON, MX")
            Position       = "Software Developer"
            Url            = "https://tiempodev.com"
            Summary        = @(
                "Implemented several software components, including synchronization and compression of audio and video content, packaging of presentations into self-contained executables, integration of image and video search APIs with retrieval capabilities and chart components."
            )
            Highlights     = @(
                "Synchronization and compression of audio and video content",
                "Packaging of Flash-based presentations into self-contained executable files for seamless delivery",
                "Integration with image and video search APIs to enhance media discovery and retrieval capabilities",
                "Seamless integration of chart components into Flypaper Studio, a digital presentation platform"
            )
            Industries     = @(
                "Custom Software & IT Services"
            )
            Keywords       = @(
                "aspnet",
                "c#",
                "C++",
                "dotnetfx",
                # "ef",
                "flypaper",
                "installshield",
                "jquery",
                "js",
                "mssql",
                "mvvm",
                "svn",
                "telerik",
                "webforms",
                "webservices",
                "winforms",
                "wpf",
                "xaml"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "ebc"
            Current        = $false
            Via            = ""
            Company        = "e-Business Consultores"
            Description    = ""
            DateStart      = "2006-01-01"
            DateEnd        = "2007-11-01"
            Location       = @("Hermosillo, SON, MX")
            Position       = "Head of Custom Development"
            Url            = ""
            Summary        = @(
                "Developed web applications creating a range of solutions that included content management systems, e-learning, e-commerce, task tracking, digital signature integration, and others."
            )
            Highlights     = @(
                "E-learning website used by Telcel to train resellers using ASP.NET Web Forms and C#.",
                "Task tracker for government dependency using digital signatures to secure and validate assigned responsibilities.",
                "Websites with content management back-end."
            )
            Industries     = @(
                "Custom Software & IT Services",
                "Government Software"
            )
            Keywords       = @(
                "dotnetfx",
                # "adonet",
                # "ado",
                "aspnet",
                "asp",
                "c#",
                "com+",
                "jquery",
                "js",
                "mssql",
                "pki",
                "svn",
                "vbnet",
                "vbscript",
                "webforms",
                "webservices",
                "XML"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "cambio"
            Current        = $false
            Via            = ""
            Company        = "Cambio Sonora"
            Description    = ""
            DateStart      = "2004-10-01"
            DateEnd        = "2006-01-01"
            Location       = @("Hermosillo, SON, MX")
            Position       = "Web Developer"
            Url            = ""
            Summary        = @(
                "Web development for newspaper's website and intranet, while also offering technical support and collaboration with the IT department."
            )
            Highlights     = @(
                "Development, maintenance, and renewal of the company's intranet modules and public website.",
                "Provided support for the IT department."
            )
            Industries     = @(
                "Newspapers & News Services"
            )
            Keywords       = @(
                # "ado",
                "asp",
                "js",
                "mssql",
                "vbscript"
            )
            ShowHighlights = $false
        },
        [Work]@{
            Id             = "dextro"
            Current        = $false
            Via            = ""
            Company        = "Dextro International"
            Description    = ""
            DateStart      = "2000-05-01"
            DateEnd        = "2004-10-01"
            Location       = @("Phoenix, AZ, US", "Remote")
            Position       = "Web Developer"
            Url            = ""
            Summary        = @(
                "Designed and developed dynamic websites with e-commerce, content management and other custom solutions."
            )
            Highlights     = @(
                "Designed and developed dynamic websites using ASP and VBScript.",
                "Handled content management, news publishing, poll management, image galleries, hit counters, product catalogs, shopping carts, online payment processing, and mailing lists."
            )
            Industries     = @(
                "Custom Software & IT Services",
                "Web Hosting",
                "Web Development"
            )
            Keywords       = @(
                # "ado",
                "asp",
                "mssql",
                "vbscript"
            )
            ShowHighlights = $false
        }
    )
    Certifications = @(
        [Certification]@{
            Name    = "Microsoft® Certified Technology Specialist: .Net Framework 2.0, Web Applications"
            Date    = "2008-06-16"
            Issuer  = "Microsoft"
            Summary = ""
        },
        [Certification]@{
            Name    = "Microsoft® Certified Professional Developer: Web Developer"
            Date    = "2008-06-16"
            Issuer  = "Microsoft"
            Summary = ""
        },
        [Certification]@{
            Name    = "Microsoft® Certified Application Developer: Microsoft .NET"
            Date    = "2006-06-01"
            Issuer  = "Microsoft"
            Summary = ""
        },
        [Certification]@{
            Name    = "Microsoft® Certified Professional: Microsoft Certified Professional"
            Date    = "2006-05-18"
            Issuer  = "Microsoft"
            Summary = ""
        }
    )
    # Publications   = @()
    # Skills         = @()
    # Volunteer      = @()
    # Education      = @()
    # Projects       = @()
    # References     = @()
    # Awards         = @()
    # Interests      = @()
    Metatags       = [Metatags]@{
        Title       = "Pablo López - Software Developer"
        Description = "Pablo is a dynamic professional known for his exceptional adaptability and collaboration skills. He consistently drives results and contributes to achieving team goals and is always looking for opportunities to expand his skill set and take on new challenges."
        SiteName    = "Pablo López - Software Developer"
        Url         = "https://pablolopez.dev"
        Type        = "website"
    }
    Keywords       = [ordered]@{
        "a11y"            = [Keyword]@{ Text = "A11Y"; Title = "Accessibility" }
        "ado"             = [Keyword]@{ Text = "ADO"; Title = "ActiveX Data Objects" }
        "adonet"          = [Keyword]@{ Text = "ADO.NET"; Title = "ActiveX Data Objects for .NET" }
        "advinstaller"    = [Keyword]@{ Text = "Advanced Installer"; Title = "Advanced Installer" }
        "apiintegration"  = [Keyword]@{ Text = "API Integration"; Title = "API Integration" }
        "asp"             = [Keyword]@{ Text = "Classic ASP"; Title = "Active Server pages" }
        "aspnet"          = [Keyword]@{ Text = "ASP.NET"; Title = "ASP.NET" }
        "aspnetcore"      = [Keyword]@{ Text = "ASP.NET Core"; Title = "ASP.NET Core" }
        "aspnetidentity"  = [Keyword]@{ Text = "ASP.NET Identity"; Title = "ASP.NET Identity" }
        "aspnetmvc"       = [Keyword]@{ Text = "ASP.NET MVC"; Title = "ASP.NET MVC" }
        "awsec2"          = [Keyword]@{ Text = "AWS EC2"; Title = "Amazon EC2" }
        "awss3"           = [Keyword]@{ Text = "AWS S3"; Title = "Amazon S3 Storage" }
        "azure"           = [Keyword]@{ Text = "Azure"; Title = "Microsoft Azure" }
        "azure_queues"    = [Keyword]@{ Text = "Azure Queues"; Title = "Azure Queues" }
        "azure_storage"   = [Keyword]@{ Text = "Azure Storage"; Title = "Azure Storage" }
        "azure_functions" = [Keyword]@{ Text = "Azure Functions"; Title = "Azure Functions" }
        "bootstrap"       = [Keyword]@{ Text = "Bootstrap"; Title = "Bootstrap Framework" }
        "c#"              = [Keyword]@{ Text = "C#"; Title = "C#" }
        "cakephp"         = [Keyword]@{ Text = "CakePHP"; Title = "CakePHP Framework" }
        "cef"             = [Keyword]@{ Text = "CEF"; Title = "Chromium Embedded Framework" }
        "com+"            = [Keyword]@{ Text = "COM+"; Title = "Component Object Model for .NET" }
        "css"             = [Keyword]@{ Text = "CSS"; Title = "Cascading Style Sheets" }
        "devexpress"      = [Keyword]@{ Text = "DevExpress"; Title = "DevExpress UI Components" }
        "docker"          = [Keyword]@{ Text = "Docker"; Title = "Docker containers" }
        "dockerwindows"   = [Keyword]@{ Text = "Docker for Windows"; Title = "Docker containers for Windows" }
        "dolbyio"         = [Keyword]@{ Text = "Dolby.io"; Title = "Dolby.io Real-Time Streaming" }
        "dotnet"          = [Keyword]@{ Text = ".NET"; Title = ".NET" }
        "dotnetce"        = [Keyword]@{ Text = ".NET CE"; Title = ".NET Compact Framework" }
        "dotnetcore"      = [Keyword]@{ Text = ".NET Core"; Title = ".NET Core" }
        "dotnetfx"        = [Keyword]@{ Text = ".NET Framework"; Title = ".NET Framework" }
        "dvdiso"          = [Keyword]@{ Text = "DVD/ISO Creation"; Title = "DVD ISO image creation" }
        "ef"              = [Keyword]@{ Text = "EF"; Title = "Entity Framework" }
        "efcore"          = [Keyword]@{ Text = "EFCore"; Title = "Entity Framework Core" }
        "ffmpeg"          = [Keyword]@{ Text = "FFmpeg"; Title = "FFmpeg Multimedia Framework" }
        "flypaper"        = [Keyword]@{ Text = "Flypaper"; Title = "Flypaper Digital Presentation Software" }
        "frozenmountain"  = [Keyword]@{ Text = "FrozenMountain"; Title = "Frozen Mountain Software" }
        "git"             = [Keyword]@{ Text = "Git"; Title = "Git Version Control" }
        "github"          = [Keyword]@{ Text = "Github"; Title = "GitHub" }
        "gitlab"          = [Keyword]@{ Text = "GitLab"; Title = "GitLab" }
        "gitlabrunners"   = [Keyword]@{ Text = "GitLab Runners"; Title = "GitLab CI/CD Runners" }
        "html"            = [Keyword]@{ Text = "HTML"; Title = "HyperText Markup Language" }
        "icelink"         = [Keyword]@{ Text = "Icelink"; Title = "Icelink WebRTC" }
        "installshield"   = [Keyword]@{ Text = "InstallShield"; Title = "InstallShield Installer Software" }
        "jquery"          = [Keyword]@{ Text = "jQuery"; Title = "jQuery Javascript Library" }
        "jqueryui"        = [Keyword]@{ Text = "jQuery-UI"; Title = "jQuery User Interface" }
        "js"              = [Keyword]@{ Text = "Javascript"; Title = "Javascript" }
        "keylok"          = [Keyword]@{ Text = "KEYLOK"; Title = "Driverless, cross-platform usb dongle security key" }
        "knockout"        = [Keyword]@{ Text = "KnockoutJS"; Title = "KnockoutJS JavaScript Library" }
        "larix"           = [Keyword]@{ Text = "Larix"; Title = "Larix Broadcaster Mobile RTMP/RTSP Streaming App" }
        "linqtosql"       = [Keyword]@{ Text = "LINQ to SQL"; Title = "Language Integrated Query to SQL" }
        "mariadb"         = [Keyword]@{ Text = "MariaDb"; Title = "MariaDB Database" }
        "millicast"       = [Keyword]@{ Text = "Millicast"; Title = "Millicast Real-Time Streaming" }
        "mindfusion"      = [Keyword]@{ Text = "MindFusion"; Title = "MindFusion UI Components" }
        "mssql"           = [Keyword]@{ Text = "MSSQL"; Title = "Microsoft SQL Server" }
        "mssqlce"         = [Keyword]@{ Text = "MSSQL CE"; Title = "Microsoft SQL Server Compact Edition" }
        "mssqlxml"        = [Keyword]@{ Text = "MSSQL XML"; Title = "Microsoft SQL Server XML Services" }
        "mui"             = [Keyword]@{ Text = "MUI"; Title = "Material UI React component library" }
        "mvc"             = [Keyword]@{ Text = "MVC"; Title = "Model View Controller" }
        "mvvm"            = [Keyword]@{ Text = "MVVM"; Title = "Model View ViewModel" }
        "mysql"           = [Keyword]@{ Text = "MySQL"; Title = "MySQL Database" }
        "netreactor"      = [Keyword]@{ Text = "NetReactor"; Title = "NetReactor .NET Obfuscator" }
        "nettiers"        = [Keyword]@{ Text = ".netTiers"; Title = ".netTiers Code Generation Framework" }
        "nswag"           = [Keyword]@{ Text = "NSwag"; Title = "NSwag OpenAPI toolchain for .NET" }
        "obfuscation"     = [Keyword]@{ Text = "Obfuscation"; Title = "Code Obfuscation" }
        "objectivec"      = [Keyword]@{ Text = "Objective-C"; Title = "Objective-C" }
        "openapi"         = [Keyword]@{ Text = "OpenAPI"; Title = "OpenAPI Specification" }
        "pki"             = [Keyword]@{ Text = "PKI"; Title = "Public Key Infrastructure" }
        "pwsh"            = [Keyword]@{ Text = "Powershell"; Title = "Windows PowerShell" }
        "razor"           = [Keyword]@{ Text = "Razor"; Title = "Razor Syntax" }
        "react"           = [Keyword]@{ Text = "React"; Title = "ReactJS" }
        "reactrouter"     = [Keyword]@{ Text = "React Router"; Title = "React Router" }
        "redux"           = [Keyword]@{ Text = "Redux"; Title = "React Redux" }
        "ror"             = [Keyword]@{ Text = "Ruby on Rails"; Title = "Ruby on Rails" }
        "rtmp"            = [Keyword]@{ Text = "RTMP"; Title = "Real-Time Messaging Protocol" }
        "ruby"            = [Keyword]@{ Text = "Ruby"; Title = "Ruby Programming Language" }
        "sass"            = [Keyword]@{ Text = "Sass"; Title = "Syntactically Awesome Stylesheets" }
        "stripe"          = [Keyword]@{ Text = "Stripe"; Title = "Stripe Payment Gateway" }
        "surescripts"     = [Keyword]@{ Text = "Surescripts"; Title = "Surescripts Healthcare Network" }
        "svn"             = [Keyword]@{ Text = "SVN"; Title = "Apache Subversion" }
        "syncfusion"      = [Keyword]@{ Text = "Syncfusion"; Title = "Syncfusion UI Components" }
        "tdd"             = [Keyword]@{ Text = "TDD"; Title = "Test Driven Development" }
        "telerik"         = [Keyword]@{ Text = "Telerik"; Title = "Telerik UI Components" }
        "tfs"             = [Keyword]@{ Text = "TFS"; Title = "Team Foundation Server" }
        "uiautomation"    = [Keyword]@{ Text = "UI Automation"; Title = "UI Automation" }
        "uwp"             = [Keyword]@{ Text = "UWP"; Title = "Universal Windows Platform" }
        "vbnet"           = [Keyword]@{ Text = "VB.NET"; Title = "Visual Basic .NET" }
        "vbscript"        = [Keyword]@{ Text = "VBScript"; Title = "Visual Basic Script" }
        "vue"             = [Keyword]@{ Text = "Vue"; Title = "Vue.js" }
        "wcag"            = [Keyword]@{ Text = "WCAG"; Title = "Web Content Accessibility Guidelines" }
        "wcf"             = [Keyword]@{ Text = "WCF"; Title = "Windows Communication Foundation" }
        "webapi"          = [Keyword]@{ Text = "Web API"; Title = "ASP.NET Web API" }
        "webforms"        = [Keyword]@{ Text = "WebForms"; Title = "ASP.NET Web Forms" }
        "webrtc"          = [Keyword]@{ Text = "WebRTC"; Title = "Web Real-Time Communication" }
        "webservices"     = [Keyword]@{ Text = "Web Services"; Title = "ASP.NET Web Services" }
        "websync"         = [Keyword]@{ Text = "Websync"; Title = "Frozen Mountain Websync" }
        "white"           = [Keyword]@{ Text = "White"; Title = "TestStack.White UI Automation Framework" }
        "winforms"        = [Keyword]@{ Text = "WinForms"; Title = "Windows Forms" }
        "winservices"     = [Keyword]@{ Text = "Windows Services"; Title = "Windows Services" }
        "wowza"           = [Keyword]@{ Text = "Wowza"; Title = "Wowza Streaming Engine" }
        "wpf"             = [Keyword]@{ Text = "WPF"; Title = "Windows Presentation Foundation" }
        "wpfui"           = [Keyword]@{ Text = "WPF UI"; Title = "WPF UI Libraries" }
        "xaml"            = [Keyword]@{ Text = "XAML"; Title = "eXtensible Application Markup Language" }
        "xcode"           = [Keyword]@{ Text = "Xcode"; Title = "Xcode IDE" }
        "kendoui"         = [Keyword]@{ Text = "Kendo UI"; Title = "Kendo UI Components" }
    }
    Meta           = @{
        FeatherIcons = @{
            'email'    = 'mail'
            'phone'    = 'phone'
            'linkedin' = 'linkedin'
            'github'   = 'github'
            'location' = 'map-pin'
            'toptal'   = 'star'
        }
    }
}

# Serialize to camelCase JSON
# $serializerSettings = [Newtonsoft.Json.JsonSerializerSettings]::new()
# $serializerSettings.ContractResolver = [Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver]::new()
# $serializerSettings.Formatting = [Newtonsoft.Json.Formatting]::Indented 
# $resumeJson = [Newtonsoft.Json.JsonConvert]::SerializeObject($resume, $serializerSettings)
# $resumeJson