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