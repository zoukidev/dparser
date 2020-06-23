import FileReader from '../utils/filereader';
import * as path from 'path';
import * as fs from 'fs';
import * as pug from 'pug';
import { Buffer } from 'buffer';

export default class Extractor {
    static browsePackageData(dirPath: string) {
        // console.log(dirPath, FileReader.checkType(dirPath));

        switch(FileReader.checkType(dirPath)) {
            case 'file':
                Extractor.extractFile(dirPath);
                break;
            case 'folder':
                fs.readdir(dirPath, (err, files: string[]) => {
                    if (err) console.log(err);
                    files.map((file: string) => {
                        Extractor.browsePackageData(path.join(dirPath, file));
                    });
                });
                break;
        }
    }

    static extractFile(filePatch: string) {
        fs.readFile(filePatch, (err, fileContent: any) => {
            if (err) console.log(err);
            // console.log(filePatch, `Buffer[${fileContent.length}]`);

            let fileFullPath = (filePatch).substr(0, filePatch.length-3).split('\\');
            fileFullPath = fileFullPath.slice(4);
            let fileData = {
                class: fileFullPath[fileFullPath.length-1],
                filePatch: filePatch,
                fileFullPath: fileFullPath,
                buffer: {
                    // content: fileContent,
                    length: fileContent.length
                }
            };

            const compiledFunction = pug.compileFile(path.join(__dirname, 'templates/test.pug'));
            console.log(compiledFunction({
                name: fileData.class
            }));
        });
    }
}