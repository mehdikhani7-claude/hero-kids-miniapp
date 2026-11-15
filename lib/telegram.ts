"use client";
declare global { interface Window { Telegram?: { WebApp?: { ready:()=>void; expand:()=>void; initData:string; initDataUnsafe?:{user?:{id:number;first_name:string;username?:string}} } } } }
export function initTelegram(){if(typeof window==="undefined")return null;const app=window.Telegram?.WebApp;if(!app)return null;app.ready();app.expand();return app;}
// initDataUnsafe is display-only. Send raw initData to a server endpoint for HMAC validation before trusting identity.
