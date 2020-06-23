import FileReader from '../utils/filereader';
import * as fs from 'fs';

export default class Extractor {
    static browsePackageData(folderPath: string) {
        fs.readdir(folderPath, (err, files: string[]) => {
            files.map((file: string) => {
                console.log(file);
            });
        });
    }
}