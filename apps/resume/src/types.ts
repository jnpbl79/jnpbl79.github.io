export interface IResume {
    basics: IBasics;
    work: WorkItem[];
}

export interface IBasics {
    name: string;
    label: string;
    picture: string;
    email: string;
    phone: string;
    website: string;
    timezone: string;
    summary: string;
    locationString: string;
}

export interface IProfile {
    network: string;
    username: string;
    url: string;
    display: boolean;
    mdIcon: string;
}

export interface WorkItem {
    id: string;
    current?: boolean;
    display?: boolean;
    via: string;
    company: string;
    description: string;
    dateStart: string;
    dateEnd: string;
    location: string[];
    position: string;
    url: string;
    summary?: string[];
    highlights?: string[];
    industries?: string[];
    keyworkds?: string[];
    summarized?: boolean;
    showHighlights?: boolean | undefined;
    showDescription?: boolean
}