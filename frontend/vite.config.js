import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  server: {
    host: true,          //外部アクセス許可
    port: 5173
  },
  plugins: [vue()],
})
