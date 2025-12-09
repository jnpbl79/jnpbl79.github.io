export interface ProductItem {
    name: string;
    description: string;
    price: number;
    images: string[];
    sold?: boolean;
    sold_to?: string;
    dibs?: string;
    display?: boolean;
}

export interface ProductList {
    products: ProductItem[];
}

export interface StroeInfo {
    store_name: string;
    owner: string;
    contact_email: string;
    whatsapp_number?: string;
}