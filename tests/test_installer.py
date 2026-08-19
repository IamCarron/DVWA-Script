#!/usr/bin/env python3
"""
Minimal test suite for Install-DVWA.sh.
Verifies Bash syntax and translation completeness.
"""

import os
import re
import subprocess
import unittest

BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
SCRIPT_PATH = os.path.join(BASE_DIR, "Install-DVWA.sh")


class TestDVWAInstaller(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        with open(SCRIPT_PATH, "r", encoding="utf-8") as f:
            cls.content = f.read()

    def test_bash_syntax(self):
        """Validate bash syntax using bash -n"""
        result = subprocess.run(
            ["bash", "-n", SCRIPT_PATH],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        self.assertEqual(result.returncode, 0, f"Syntax error: {result.stderr}")

    def _get_translations(self, array_name):
        match = re.search(rf"{array_name}=\(\s*(.*?)\s*\n\)", self.content, re.DOTALL)
        self.assertIsNotNone(match, f"Missing array {array_name}")
        keys = set()
        for line in match.group(1).splitlines():
            line = line.strip()
            if line and not line.startswith("#"):
                m = re.match(r'\["([^"]+)"\]', line)
                if m:
                    keys.add(m.group(1))
        return keys

    def test_translations_synchronized(self):
        """Verify all 3 languages have identical translation keys"""
        en = self._get_translations("en_strings")
        es = self._get_translations("es_strings")
        fr = self._get_translations("fr_strings")

        self.assertEqual(en, es, f"Difference between EN and ES: {en ^ es}")
        self.assertEqual(en, fr, f"Difference between EN and FR: {en ^ fr}")


if __name__ == "__main__":
    unittest.main()
