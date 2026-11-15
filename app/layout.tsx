import type { Metadata, Viewport } from "next";
import "./globals.css";
import Script from "next/script";
export const metadata: Metadata = { title: "Hero Kids | همراه رشد و حرکت", description: "مینی‌اپ باشگاه بازی و ورزش کودکان Hero Kids", applicationName: "Hero Kids" };
export const viewport: Viewport = { width: "device-width", initialScale: 1, maximumScale: 1, themeColor: "#14243b" };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="fa" dir="rtl"><body><Script src="https://telegram.org/js/telegram-web-app.js" strategy="beforeInteractive" />{children}</body></html>; }
