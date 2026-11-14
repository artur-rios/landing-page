import { defineConfig, globalIgnores } from "eslint/config"
import nextVitals from "eslint-config-next/core-web-vitals"

const eslintConfig = defineConfig([
  ...nextVitals,
  // The default ignores of eslint-config-next.
  globalIgnores([".next/**", "out/**", "build/**", "next-env.d.ts"]),
  {
    rules: {
      // react-hooks/immutability is an experimental rule in react-hooks@7 that reports browser API
      // assignments such as window.location.href (contact-form.tsx) as mutations.
      "react-hooks/immutability": "off",
    },
  },
])

export default eslintConfig
