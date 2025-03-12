# How to Add Your Logo to TuneBoxed

Follow these steps to add your own custom logo to the TuneBoxed app's loading screen:

## Option 1: Using Xcode's Assets Catalog (Recommended)

1. Open the project in Xcode by double-clicking on `TuneBoxedSimple.xcodeproj`
2. In the Project Navigator (left sidebar), find and click on `Assets.xcassets`
3. You'll see a folder called `Logo` - this is where your logo should go
4. Drag and drop your logo image file directly onto the empty squares in the Logo section
   - For best results, provide images for all three scales (1x, 2x, 3x)
   - Use PNG format with transparency for best results
   - Recommended sizes: 100x100px (1x), 200x200px (2x), 300x300px (3x)
5. Build and run the app - your logo will automatically appear on the loading screen

## Option 2: Replace the Logo in Finder

1. Navigate to `/Users/boxzr/Desktop/TuneBoxedSimple/TuneBoxedSimple/Assets.xcassets/Logo.imageset`
2. Add your logo image files directly to this folder
3. Make sure to name them appropriately:
   - `logo.png` (for 1x)
   - `logo@2x.png` (for 2x)
   - `logo@3x.png` (for 3x)
4. Edit the `Contents.json` file to include your filenames:
   ```json
   {
     "images" : [
       {
         "filename" : "logo.png",
         "idiom" : "universal",
         "scale" : "1x"
       },
       {
         "filename" : "logo@2x.png",
         "idiom" : "universal",
         "scale" : "2x"
       },
       {
         "filename" : "logo@3x.png",
         "idiom" : "universal",
         "scale" : "3x"
       }
     ],
     "info" : {
       "author" : "xcode",
       "version" : 1
     }
   }
   ```

## Logo Design Tips

- Use a square image for best results
- Include transparency (PNG format) so it blends well with the purple background
- Keep it simple and recognizable at small sizes
- If you don't add a logo, the app will use the text "TB" as a fallback

## Troubleshooting

- If your logo doesn't appear, make sure the image name in the Assets catalog matches exactly what's in the code
- Try cleaning the build folder (Shift+Cmd+K) and rebuilding
- Make sure your image files are in a supported format (PNG, JPG) 