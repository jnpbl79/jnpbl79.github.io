export interface ProductItem {
    name: string;
    description: string;
    price: number;
    images: string[];
    sold?: boolean;
    sold_to?: string;
    dibs?: string;
    display?: boolean;
    category?: string;
}

export interface ProductList {
    products: ProductItem[];
}

export interface StoreInfo {
    title: string;
    wa_link: string;
    contact_email: string;
    items: ProductItem[];
}

export type ProductsFilter = 'all' | 'sold' | 'dibs'; 