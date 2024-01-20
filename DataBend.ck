
// DataBend.ck
// JP Yepez 2017

// Instructions:
// Takes data from the files in the 'Input' folder 
// and outputs an audio file for each one of them.
// Requires '--caution-to-the-wind' flag.
// Recommended '-s' flag (silent)

////
// Audio setup
Impulse imp => Gain master => WvOut wvout => blackhole;

// Set gain
0.2 => master.gain;


////
// DataBend class
class DataBend {

    static FileIO @ file;

    // Initialize
    fun static void init() {
        new FileIO @=> file;
    }

    // Get data and output file
    // Argument: filename
    fun static void get(string name) {

        // Open input file
        if(!file.open(me.dir() + "Input/" + name, FileIO.BINARY )){

            cherr <= "\tCould not open file " <= name <= ".\n" <= IO.nl();

        } else {
            
            // If successful, start recording
            me.dir() + "Output/" + name => wvout.wavFilename;
            chout <= "\tWriting to file: " <= wvout.filename() <= IO.nl();
            wvout.record(1);

            // Output samples
            while(!file.eof()) {
                file.readInt(4) => int val;
                // chout <= "\t" <= val/200.0 <= IO.nl();    // (debug) print values
                imp.next(val/200.0);                         // scale down values by 200
                samp => now;
            }

            // Stop recording and close input file
            wvout.record(0);
            file.close();
        }
    }
}


////
// Get all local filenames (bash)
chout <=  "\n\n\tGetting local filenames..." <= IO.nl();
Std.system("cd Input && ls *.* > ../localFiles.txt");
Std.system("mkdir Output");   // Create output folder

// Filename variables
FileIO files;
string filenames[0];

// Exit script if "localFiles.txt" cannot be opened
if(!files.open(me.dir() + "localFiles.txt", FileIO.READ )){
    cherr <=  "\tCannot open localFiles.txt";
    me.exit();
}

// Store filenames in array
while(!files.eof()) {
    files.readLine() => string file;
    filenames << file;
}

// Print results
chout <= "\n\tFound " <= filenames.size() - 1 + " files.\n\n";
for(int i; i < filenames.size(); i++) {
    chout <= "\t" <= filenames[i] <= IO.nl();
}

// Close "localFiles.txt"
files.close();

////
// Load files into DataBend class
DataBend.init();

for(int i; i < filenames.size(); i++) {
    DataBend.get(filenames[i]);
}

// Print upon completion
chout <=  "\n\tDataBending complete!\n" <= IO.nl();

