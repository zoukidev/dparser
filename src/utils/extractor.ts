import FileReader from '../utils/filereader';
import * as path from 'path';
import * as fs from 'fs';

export default class Extractor {
    static browsePackageData(folderPath: string) {
        fs.readdir(folderPath, (err, files: string[]) => {
            if (err) console.log(err);
            if (FileReader.checkFolder(folderPath)) {
                files.map((file: string) => {
                    if (FileReader.checkFolder(path.join(folderPath, file))) {
                        Extractor.browsePackageData(path.join(folderPath, file));
                    } else {
                        Extractor.extractFile(path.join(folderPath, file))
                    }
                });
            }
        });
    }

    static extractFile(filePatch: string) {
        if (FileReader.checkFolder(filePatch)) {
            Extractor.browsePackageData(filePatch);
        } else {
            fs.readFile(filePatch, (err, fileContent: any) => {
                if (err) console.log(err);
                console.log(filePatch);
                // console.log(fileContent);
            });
        }
    }
}