import './globals.css';
import type { ReactNode } from 'react';

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="ru">
      <body className="min-h-screen bg-gray-50 text-gray-900">
        <div className="border-b bg-yellow-50 text-yellow-900 text-sm p-2 text-center">
          Это симуляция. Веб‑приложение не связано с Telegram.
        </div>
        {children}
      </body>
    </html>
  );
}

