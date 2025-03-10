#!/bin/bash
#
# Vim Configuration Tester
# Tests vimrc for syntax errors and plugin configuration
#

set -e  # Exit on any error
VIMRC_PATH="$(pwd)/vimrc"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo "=== Vim Configuration Test ==="
echo "Testing vimrc at: $VIMRC_PATH"

# Function to print test results
print_result() {
  if [ $1 -eq 0 ]; then
    echo -e "${GREEN}PASS${NC}: $2"
  else
    echo -e "${RED}FAIL${NC}: $2"
    if [ -n "$3" ]; then
      echo -e "${YELLOW}Details: $3${NC}"
    fi
    FAILED=1
  fi
}

# Initialize failure flag
FAILED=0

# Test 1: Check if vimrc exists
echo -e "\n=> Checking if vimrc exists"
if [ -f "$VIMRC_PATH" ]; then
  print_result 0 "vimrc file exists"
else
  print_result 1 "vimrc file not found" "Expected at $VIMRC_PATH"
  exit 1  # No point continuing if vimrc doesn't exist
fi

# Test 2: Check vimrc syntax using vim's internal syntax checker
echo -e "\n=> Testing vimrc syntax"
SYNTAX_CHECK=$(vim -u NONE -N --noplugin -e -s -c "source $VIMRC_PATH" -c quit 2>&1)
if [ -z "$SYNTAX_CHECK" ]; then
  print_result 0 "No syntax errors detected in vimrc"
else
  print_result 1 "Syntax errors found in vimrc" "$SYNTAX_CHECK"
fi

# Test 3: Verify essential settings are present
echo -e "\n=> Checking for essential settings"
ESSENTIAL_SETTINGS=(
  "let mapleader"
  "call plug#begin"
  "set expandtab"
  "filetype plugin indent on"
)

for setting in "${ESSENTIAL_SETTINGS[@]}"; do
  if grep -q "$setting" "$VIMRC_PATH"; then
    print_result 0 "Found essential setting: $setting"
  else
    print_result 1 "Missing essential setting: $setting" "Please add this to your vimrc"
  fi
done

# Test 4: Check plugin structure 
echo -e "\n=> Verifying plugin structure"
if grep -q "call plug#begin" "$VIMRC_PATH" && grep -q "call plug#end" "$VIMRC_PATH"; then
  PLUGIN_COUNT=$(grep -c "Plug '" "$VIMRC_PATH")
  print_result 0 "Plugin structure is valid with $PLUGIN_COUNT plugins"
else
  print_result 1 "Invalid plugin structure" "Missing call plug#begin() or call plug#end()"
fi

# Test 5: Verify key plugins are included
echo -e "\n=> Checking for key plugins"
KEY_PLUGINS=(
  "vim-sensible"
  "nerdtree"
  "YouCompleteMe"
  "ale"
)

for plugin in "${KEY_PLUGINS[@]}"; do
  if grep -q "$plugin" "$VIMRC_PATH"; then
    print_result 0 "Found key plugin: $plugin"
  else
    print_result 1 "Missing key plugin: $plugin" "Consider adding this to your vimrc"
  fi
done

# Test 6: Check mapping for leader key
echo -e "\n=> Verifying leader key is set correctly"
if grep -q "let mapleader" "$VIMRC_PATH"; then
  print_result 0 "Leader key is defined"
else
  print_result 1 "Leader key may not be set" "Recommended: Add 'let mapleader = \"\\\"' to your vimrc"
fi

# Test 7: Verify NERDTree toggle mapping exists
echo -e "\n=> Checking NERDTree mapping"
if grep -q "<leader><tab> :NERDTreeToggle" "$VIMRC_PATH"; then
  print_result 0 "NERDTree toggle mapping exists"
else
  print_result 1 "NERDTree toggle mapping not found" "Expected mapping with <leader><tab>"
fi

# Test 8: Check language configurations
echo -e "\n=> Verifying language configurations"
if grep -q "augroup language_settings" "$VIMRC_PATH"; then
  print_result 0 "Language settings are properly organized"
else
  print_result 1 "Language settings should be in an augroup" "Consider reorganizing language configurations"
fi

# Test 9: Check for key mappings documentation
echo -e "\n=> Checking for key mappings documentation"
if grep -q "KEY MAPPINGS REFERENCE" "$VIMRC_PATH"; then
  print_result 0 "Key mappings documentation found"
else
  print_result 1 "Missing key mappings documentation" "Consider adding a section documenting key mappings"
fi

# Final result
echo -e "\n=== Test Summary ==="
if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}All tests passed! Your vimrc looks good.${NC}"
  echo "To test your configuration in actual vim:"
  echo "  1. Run: vim -u $VIMRC_PATH"
  echo "  2. Verify plugins loaded with: :PlugStatus"
  echo "  3. Test NERDTree toggle with: \\<tab>"
else
  echo -e "${RED}Some tests failed. Please check the errors above.${NC}"
  echo "Fix the issues and run this test again."
fi

exit $FAILED