$(document).ready(function() {
    // Function to fetch programs from backend and populate the program dropdown
    function fetchPrograms() {
        $.ajax({
            url: 'http://localhost/lms/student/api/dropdown/fetch_programs.php',
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                var programDropdown = $('#filterProgram');
                programDropdown.empty();
                programDropdown.append($('<option></option>').attr('value', '').text('All Programs')); // Add option for all programs
                $.each(response, function(index, program) {
                    programDropdown.append($('<option></option>').attr('value', program.ProgramCode).text(program.ProgramCode));
                });
            },
            error: function(xhr, status, error) {
                console.error('Error fetching programs:', error);
            }
        });
    }

    // Function to fetch domains based on the selected program and populate the domain dropdown
    function fetchDomains(programCode) {
        $.ajax({
            url: 'http://localhost/lms/student/api/dropdown/fetch_domains.php',
            type: 'GET',
            dataType: 'json',
            data: { programCode: programCode },
            success: function(response) {
                var domainDropdown = $('#filterDomain');
                domainDropdown.empty();
                domainDropdown.append($('<option></option>').attr('value', '').text('All Domains')); // Add option for all domains
                $.each(response, function(index, domain) {
                    domainDropdown.append($('<option></option>').attr('value', domain.DomainName).text(domain.DomainName));
                });
                console.log('Domains populated:', response); // Debug log for domains
            },
            error: function(xhr, status, error) {
                console.error('Error fetching domains:', error);
            }
        });
    }

    // Fetch programs and populate program dropdown
    fetchPrograms();

    // Event listener for program dropdown change
    $('#filterProgram').change(function() {
        var programCode = $(this).val();
        if (programCode !== '') {
            fetchDomains(programCode);
        } else {
            $('#filterDomain').empty().append($('<option></option>').attr('value', '').text('All Domains')); // Reset domain dropdown
        }
        // filterTableData(); // Trigger filtering
        filterMaterialData();
    });

    // Event listener for domain dropdown change
    $('#filterDomain').change(function() {
        // filterTableData(); // Trigger filtering
        filterMaterialData();
    });

    // Function to filter table data based on selected program and domain
    function filterTableData() {
        var selectedProgram = $('#filterProgram').val();
        var selectedDomain = $('#filterDomain').val();
        console.log('Filtering table with Program:', selectedProgram, 'and Domain:', selectedDomain); // Debug log for filtering criteria

        // Loop through table rows and show/hide based on selected program and domain
        $('#courseList > tr').each(function() {
            var program = $(this).find('td:eq(1)').text().trim(); // Index of Program column
            var domain = $(this).find('td:eq(2)').text().trim(); // Index of Domain column
            console.log('Row program:', program, 'Row domain:', domain); // Debug log for row content
            if ((selectedProgram === '' || program === selectedProgram) &&
                (selectedDomain === '' || domain === selectedDomain)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    function filterMaterialData() {
        var selectedProgram = $('#filterProgram').val();
        var selectedDomain = $('#filterDomain').val();

        console.log('Filtering table with Program:', selectedProgram, 'and Domain:', selectedDomain); // Debug log for filtering criteria
    
        // Loop through table rows and show/hide based on selected program and domain
        $('#materialList > tr').each(function() {
            var program = $(this).find('td:eq(5)').text().trim(); // Index of Program column
        
            var domain = $(this).find('td:eq(6)').text().trim(); // Index of Domain column

            console.log('Row program:', program, 'Row domain:', domain); // Debug log for row content
            if ((selectedProgram === '' || program === selectedProgram) &&
                (selectedDomain === '' || domain === selectedDomain)) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    // Rest of your JavaScript code
});
