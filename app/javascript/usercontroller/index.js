import swal from 'sweetalert2/dist/sweetalert2.all.min.js'

// Group More Info Popover Animation
function groupDeleteMoreInfo() {
  const popovers = document.querySelectorAll(".popover-info-btn")
  popovers.forEach((popoverBtn) => {
    popoverBtn.addEventListener("click", () => {
      swal({
        position: 'top-right',
        type: 'info',
        title: '<h3> Want to delete a group? </h3>',
        text: "A kitty can only be closed when there are no remaining outstanding payments",
        showConfirmButton: true,
        confirmButtonText: '<i class="fa fa-thumbs-up"></i>',
        confirmButtonColor: '#00B8D8',
        timer: 4000
      })
    })
  })
}

export { groupDeleteMoreInfo };
