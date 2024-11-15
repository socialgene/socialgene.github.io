
<h1>FASTA Hasher</h1>
    <p>This tool hashes the sequence of each FASTA entry using sha512t24, described in:</p>
    <cite>Hart, R. K. &amp; Prlić, A. SeqRepo: A system for managing local collections of biological sequences. PLoS One 15, (2020).</cite>
    
    <br><br>
    <textarea id="fastaInput" rows="10" cols="50" placeholder="Paste your FASTA sequence here"></textarea><br>
    <button onclick="processFasta()">Generate Hashed FASTA</button>
    <button onclick="clearAll()">Clear All</button>
    <h2>FASTA with deflines replaced with sha512t24 hash</h2>
    <textarea id="fastaOutput" rows="10" cols="50" readonly></textarea><br>
    <button onclick="downloadFasta()">Download FASTA</button>
    <h2>TSV mapping input deflines to sha512t24 hash</h2>
    <textarea id="deflineMap" rows="10" cols="50" readonly></textarea><br>
    <button onclick="downloadMap()">Download Defline Map</button>

    <script>
        async function sha512t24u(input) {
            const encoder = new TextEncoder();
            const data = encoder.encode(input.toUpperCase());
            const hashBuffer = await crypto.subtle.digest('SHA-512', data);
            const first24Bytes = hashBuffer.slice(0, 24);
            const base64String = btoa(String.fromCharCode(...new Uint8Array(first24Bytes)))
                .replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
            return base64String;
        }

        async function processFasta() {
            const fastaInput = document.getElementById("fastaInput").value;
            const lines = fastaInput.split("\n");

            let result = "";
            let deflineMap = ""; // No header
            let currentDefline = "";
            let sequenceBuffer = "";

            for (let i = 0; i < lines.length; i++) {
                const line = lines[i].trim();

                if (line.startsWith(">")) {
                    if (currentDefline && sequenceBuffer) {
                        // Normalize sequence by removing all non-alphabetic characters
                        const normalizedSequence = sequenceBuffer.replace(/[^A-Za-z]/g, "");
                        const hash = await sha512t24u(normalizedSequence); // Hash the normalized sequence
                        result += `>${hash}\n${sequenceBuffer}\n`;
                        deflineMap += `${currentDefline}\t${hash}\n`;
                    }

                    // Start a new defline and reset sequence buffer
                    currentDefline = line.slice(1).replace(/\t/g, "").trim();  // Remove ">", tabs, and trim whitespace
                    sequenceBuffer = "";
                } else {
                    sequenceBuffer += line;  // Accumulate sequence lines into a single sequence
                }
            }

            // Process the last sequence and defline
            if (currentDefline && sequenceBuffer) {
                const normalizedSequence = sequenceBuffer.replace(/[^A-Za-z]/g, "");
                const hash = await sha512t24u(normalizedSequence); // Hash the normalized sequence
                result += `>${hash}\n${sequenceBuffer}\n`;
                deflineMap += `${currentDefline}\t${hash}\n`;
            }

            document.getElementById("fastaOutput").value = result.trim();
            document.getElementById("deflineMap").value = deflineMap.trim();
        }

        function downloadFasta() {
            const fastaOutput = document.getElementById("fastaOutput").value;
            const blob = new Blob([fastaOutput], { type: 'text/plain' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'output.fasta';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }

        function downloadMap() {
            const deflineMap = document.getElementById("deflineMap").value;
            const blob = new Blob([deflineMap], { type: 'text/tab-separated-values' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'defline_map.tsv';
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
        }

        function clearAll() {
            document.getElementById("fastaInput").value = "";
            document.getElementById("fastaOutput").value = "";
            document.getElementById("deflineMap").value = "";
        }
    </script>

